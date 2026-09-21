local function freezeCards(cards)
    for _, card in ipairs(cards) do table.freeze(card) end
    return table.freeze(cards)
end
local characters = {
    rollo_ravioluna = {
        Id = "rollo_ravioluna", Name = "Rollo Rollo Ravioluna", Rarity = "Common",
        Desire = "A long path and useful work.", Concern = "My moon wheels could crush the flowers.",
        Turns = 2, TrustTarget = 30, Required = table.freeze({ reason = true, example = true }),
        Claims = freezeCards({
            { Id="rollo_path", Label="Join the Moon Meadow path crew", Tags={claim=true}, Trust=10 },
            { Id="rollo_party", Label="Run the loudest party", Tags={claim=true}, Trust=10 },
        }),
        Supports = freezeCards({
            { Id="rollo_reason", Label="Your wheels fit the long delivery paths", Tags={reason=true}, Trust=10 },
            { Id="rollo_example", Label="Use raised lanes so flowers stay safe", Tags={example=true,concern=true}, Trust=20 },
            { Id="rollo_repeat", Label="Because rolling is fun", Tags={}, Trust=0 },
        }),
    },
    frizzolo_faxolotl = {
        Id = "frizzolo_faxolotl", Name = "Frizzolo Faxolotl", Rarity = "Rare",
        Desire = "Transmit stories for the whole habitat.", Concern = "The fax noise disturbs quiet residents.",
        Turns = 3, TrustTarget = 55, Required = table.freeze({ reason=true, example=true, tradeoff=true }),
        Claims = freezeCards({
            { Id="frizzolo_archive", Label="Run the habitat story archive", Tags={claim=true}, Trust=10 },
            { Id="frizzolo_alarm", Label="Fax every message immediately", Tags={claim=true}, Trust=10 },
        }),
        Supports = freezeCards({
            { Id="frizzolo_reason", Label="Residents keep memories without losing them", Tags={reason=true}, Trust=10 },
            { Id="frizzolo_example", Label="Print one evening story bulletin", Tags={example=true}, Trust=10 },
            { Id="frizzolo_tradeoff", Label="Use quiet hours and an urgent-only slot", Tags={tradeoff=true,concern=true}, Trust=25 },
        }),
    },
}
for _, character in pairs(characters) do
    table.freeze(character)
end
return table.freeze(characters)
