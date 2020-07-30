-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMonsterMagicPrepare(mob, target)
    if (mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS, 0) == false) then
        local rnd = math.random()
        if (rnd < 0.5) then
            return 186 -- aeroga 3
        elseif (rnd < 0.7) then
            return 157 -- aero 4
        elseif (rnd < 0.9) then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller)
end
