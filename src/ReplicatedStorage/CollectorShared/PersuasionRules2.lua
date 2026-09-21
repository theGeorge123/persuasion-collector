local Rules = {}
local function hasAll(found, required)
    for tag in pairs(required) do if not found[tag] then return false end end
    return true
end
function Rules.New(character)
    return { CharacterId=character.Id, Turn=1, Trust=0, Found={}, Used={}, Complete=false }
end
function Rules.Apply(state, character, claimId, supportId)
    assert(not state.Complete, "encounter already complete")
    local claim, support
    for _, card in ipairs(character.Claims) do if card.Id == claimId then claim = card break end end
    for _, card in ipairs(character.Supports) do if card.Id == supportId then support = card break end end
    if not claim or not support then return nil, "UNKNOWN_CARD" end
    local gained, reasons = 0, {}
    for _, card in ipairs({claim, support}) do
        if not state.Used[card.Id] then
            state.Used[card.Id] = true
            gained += card.Trust
            for tag, enabled in pairs(card.Tags) do if enabled then state.Found[tag] = true end end
            if card.Trust > 0 then table.insert(reasons, card.Label) end
        end
    end
    state.Trust += gained
    local lastTurn = state.Turn >= character.Turns
    state.Complete = state.Trust >= character.TrustTarget and hasAll(state.Found, character.Required)
    state.Turn += 1
    return { Gained=gained, Reasons=reasons, Trust=state.Trust, Complete=state.Complete, Exhausted=lastTurn and not state.Complete, Found=state.Found }
end
return table.freeze(Rules)
