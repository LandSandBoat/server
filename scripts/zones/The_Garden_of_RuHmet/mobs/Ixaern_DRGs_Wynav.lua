-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG's Wynav
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("hpTrigger", math.random(10, 75))
end

function onMobFight(mob, target)
    local hpTrigger = mob:getLocalVar("hpTrigger")
    if (mob:getLocalVar("SoulVoice") == 0 and mob:getHPP() <= hpTrigger) then
        mob:setLocalVar("SoulVoice", 1)
        mob:useMobAbility(696) -- Soul Voice
    end
end

function onMonsterMagicPrepare(mob, target)
    local spellList =
    {
        [1] = 382,
        [2] = 376,
        [3] = 372,
        [4] = 392,
        [5] = 397,
        [6] = 400,
        [7] = 422,
        [8] = 462,
        [9] = 466 -- Virelai (charm)
    }
    if (mob:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        return spellList[math.random(1, 9)] -- Virelai possible.
    else
        return spellList[math.random(1, 8)] -- No Virelai!
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("repop", mob:getBattleTime()) -- This get erased on respawn automatic.
end
