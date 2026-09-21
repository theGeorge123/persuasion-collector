local RS=game:GetService("ReplicatedStorage");local Players=game:GetService("Players")
local remotes=RS:WaitForChild("PersuasionCollectorRemotes");local action=remotes:WaitForChild("Action");local state=remotes:WaitForChild("State")
local gui=Instance.new("ScreenGui");gui.Name="PersuasionCollectorUI";gui.ResetOnSpawn=false;gui.Parent=Players.LocalPlayer:WaitForChild("PlayerGui")
local frame=Instance.new("Frame");frame.AnchorPoint=Vector2.new(.5,.5);frame.Position=UDim2.fromScale(.5,.5);frame.Size=UDim2.new(.92,0,.86,0);frame.BackgroundColor3=Color3.fromRGB(24,31,51);frame.Parent=gui
local layout=Instance.new("UIListLayout");layout.Padding=UDim.new(0,8);layout.Parent=frame
local function button(text)local b=Instance.new("TextButton");b.Size=UDim2.new(1,-20,0,48);b.Text=text;b.TextScaled=true;b.BackgroundColor3=Color3.fromRGB(65,160,130);b.TextColor3=Color3.new(1,1,1);b.Parent=frame;return b end
local title=Instance.new("TextLabel");title.Size=UDim2.new(1,-20,0,80);title.TextWrapped=true;title.TextScaled=true;title.BackgroundTransparency=1;title.TextColor3=Color3.new(1,1,1);title.Text="PERSUASION COLLECTOR\nAUTHORED CHOICES • SESSION ONLY";title.Parent=frame
local rollo=button("MEET ROLLO (COMMON)");local frizzolo=button("MEET FRIZZOLO (RARE)");local rewrite=button("REWRITE — PREVIEW ONLY");rewrite.BackgroundColor3=Color3.fromRGB(80,80,100)
rollo.Activated:Connect(function()action:FireServer("Start","rollo_ravioluna")end);frizzolo.Activated:Connect(function()action:FireServer("Start","frizzolo_faxolotl")end)
local dynamic={}
local function clear()for _,x in ipairs(dynamic)do x:Destroy()end;table.clear(dynamic)end
local function add(text,color)local b=button(text);b.BackgroundColor3=color or Color3.fromRGB(63,95,170);table.insert(dynamic,b);return b end
state.OnClientEvent:Connect(function(m)clear();if m.Kind=="Encounter"then title.Text=("%s • %s\nWants: %s\nConcern: %s\nTrust %d/%d • Turn %d/%d"):format(m.Character.Name,m.Character.Rarity,m.Character.Desire,m.Character.Concern,m.State.Trust,m.Character.TrustTarget,m.State.Turn,m.Character.Turns);for _,claim in ipairs(m.Character.Claims)do for _,support in ipairs(m.Character.Supports)do local b=add(claim.Label.."\n+ "..support.Label);b.Activated:Connect(function()action:FireServer("Submit",{ClaimId=claim.Id,SupportId=support.Id})end)end end elseif m.Kind=="Recruited"then title.Text="RECRUITED!\n"..m.CharacterId.."\n"..m.Message;add("COLLECTION OWNERSHIP SURVIVES THIS SESSION",Color3.fromRGB(130,80,170))elseif m.Kind=="Error"then title.Text="That authored choice was invalid: "..tostring(m.Code)end end)
