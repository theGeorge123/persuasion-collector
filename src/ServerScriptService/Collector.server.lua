local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Shared = ReplicatedStorage:WaitForChild("CollectorShared")
local Config = require(Shared.Config)
local Characters = require(Shared.Characters)
local Rules = require(Shared.PersuasionRules2)

assert(not Config.PersistenceEnabled and not Config.MonetizationEnabled and not Config.FreeTextEnabled and not Config.RewriteEnabled)
local folder = Instance.new("Folder"); folder.Name = "PersuasionCollectorRemotes"; folder.Parent = ReplicatedStorage
local action = Instance.new("RemoteEvent"); action.Name = "Action"; action.Parent = folder
local stateRemote = Instance.new("RemoteEvent"); stateRemote.Name = "State"; stateRemote.Parent = folder
local sessions = {}
local owned = {}

local function public(character, state)
    return {Kind="Encounter", Character={Id=character.Id,Name=character.Name,Rarity=character.Rarity,Desire=character.Desire,Concern=character.Concern,Turns=character.Turns,TrustTarget=character.TrustTarget,Claims=character.Claims,Supports=character.Supports,Required=character.Required}, State={Turn=state.Turn,Trust=state.Trust,Complete=state.Complete,Found=state.Found}}
end
local function start(player, characterId)
    local character = Characters[characterId]
    if not character then return end
    local state = Rules.New(character); sessions[player] = {Character=character,State=state}
    stateRemote:FireClient(player, public(character,state))
end

action.OnServerEvent:Connect(function(player, kind, payload)
    if kind == "Start" and type(payload)=="string" then start(player,payload); return end
    if kind ~= "Submit" or type(payload)~="table" then return end
    local session=sessions[player]; if not session then return end
    local result,err=Rules.Apply(session.State,session.Character,payload.ClaimId,payload.SupportId)
    if not result then stateRemote:FireClient(player,{Kind="Error",Code=err});return end
    if result.Complete then
        owned[player]=owned[player] or {};owned[player][session.Character.Id]=true
        stateRemote:FireClient(player,{Kind="Recruited",CharacterId=session.Character.Id,Trust=result.Trust,Owned=owned[player],Message="Recruited through authored choices. No AI judgment or paid power."})
        sessions[player]=nil
    else stateRemote:FireClient(player,public(session.Character,session.State)) end
end)
Players.PlayerRemoving:Connect(function(player) sessions[player]=nil;owned[player]=nil end)
