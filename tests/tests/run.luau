-- Run from repository root with Luau.
local function load(path) return require(path) end
local Characters=load("../src/ReplicatedStorage/CollectorShared/Characters")
local Rules=load("../src/ReplicatedStorage/CollectorShared/PersuasionRules")
local rollo=Characters.rollo_ravioluna
local s=Rules.New(rollo)
local a=assert(Rules.Apply(s,rollo,"rollo_path","rollo_reason"));assert(a.Trust==20 and not a.Complete)
local b=assert(Rules.Apply(s,rollo,"rollo_path","rollo_example"));assert(b.Trust==40 and b.Complete)
local frizzolo=Characters.frizzolo_faxolotl;local f=Rules.New(frizzolo)
assert(Rules.Apply(f,frizzolo,"frizzolo_archive","frizzolo_reason").Trust==20)
assert(Rules.Apply(f,frizzolo,"frizzolo_archive","frizzolo_example").Trust==30)
local done=Rules.Apply(f,frizzolo,"frizzolo_alarm","frizzolo_tradeoff");assert(done.Trust==65 and done.Complete)
local bad,err=Rules.Apply(Rules.New(rollo),rollo,"missing","rollo_reason");assert(bad==nil and err=="UNKNOWN_CARD")
print("Persuasion Collector pure tests passed")
