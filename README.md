# Persuasion Collector

Isolated review MVP for a separate Roblox game. It does not import or modify Beat the Bot.

## Scope
- one session-only habitat shell;
- two original authored recruits;
- claim + support argument builder;
- transparent Trust meter;
- two active-slot concept and locked Epic/Rewrite are presentation-only follow-ups;
- no free text, persistence, monetization, ads, chance, Robux, publishing or live AI.

## Build
```bash
rojo build collector.project.json -o build/PersuasionCollectorMVP.rbxlx
open build/PersuasionCollectorMVP.rbxlx
```

## Test
Run `luau tests/run.luau`, then open Studio and use Test > 1 client > Start. Test both encounters, unknown card rejection and repeated-card zero reward. Mobile pixel verification remains required.

See `docs/ASSET_PROVENANCE.md` before adding external models.
