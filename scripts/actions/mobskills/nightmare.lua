-----------------------------------
-- Nightmare - NM Diabolos
-- AoE Sleep
-- Sleep that is not broken from DoT effects (any dmg source that doesn't break bind).
-- + I.e. if a mob has helix, nightmare will still sleep the target
-- When this sleep is applied, it is accompanied by a Bio effect. That Bio effect doesn't break _any_ types of sleep
-- + I.e. if you nightmare a mob, then layer sleep II, the mob will stay asleep
-- The Bio does that by explicitly dealing lua dmg each tick with the `wakeUp` flag set to false.
--
-- This NM/Mob version of sleep also doesn't break from any other dmg sources
-- + I.e. NM diabolos applies nightmare, then uses Camisado. You will not wake up
-- the identifier for this more-powerful Nightmare sleep is when the tier > 1. There are references other files
-- + status_effect_container.cpp
-- + lua_baseentity.cpp
-- + actions/pets/nightmare.lua
-- + effects/sleep.lua
-- + effects/bio.lua
--
-- DoT damage is 2/tick for player avatars and 15/tick for NM/Mobs
--
-- TL;DR - SLEEP_I with tier > 0 is a nightmare sleep. Tier > 1 is an NM/mob nightmare that can't be broken except from cures
--
-- Note that the sleep effect is not the thing doing damage. When nightmare is applied, you also get a Bio effect
-- if you erase the bio effect, the Sleep (with a tier > 0) still behaves exactly the same as before
-- The AMOUNT of damage done to the target is irrelevant to the behavior of nightmare sleep, only the source of the damage and the source of the Nightmare.
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dotdamage = 15
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(20, 30), 0, dotdamage, 2))

    return xi.effect.SLEEP_I
end

return mobskillObject
