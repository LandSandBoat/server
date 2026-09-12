-----------------------------------
--  MOB: Hydra
-- Area: Nyzul Isle
-- Info: Floor 60 80 and 100 Boss
-----------------------------------
mixins =
{
    require('scripts/mixins/nyzul_boss_drops'),
    require('scripts/mixins/families/hydra'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function handleRegen(mob, broken)
    local multiplier = (2 - broken) * 0.75
    mob:setMod(xi.mod.REGEN, math.floor(25 * multiplier))
    mob:setMod(xi.mod.REGAIN, math.floor(25 * multiplier))
end

entity.onMobInitialize = function(mob)
    -- Set Immunities.
    -- mob:addImmunity(xi.immunity.GRAVITY)
    -- mob:addImmunity(xi.immunity.BIND)
    -- mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.UDMGMAGIC, -9000)
    mob:setMod(xi.mod.POISON_MEVA, 100)
    mob:setMod(xi.mod.BLIND_MEVA, 100)
    mob:setMod(xi.mod.SILENCE_MEVA, 100)
    mob:setMod(xi.mod.SLOW_MEVA, 100)
    mob:setMod(xi.mod.STUN_MEVA, 175)
    mob:setMod(xi.mod.SLEEP_MEVA, 150)
    mob:setMod(xi.mod.DEFP, 35)
    mob:addMod(xi.mod.EVA, 15)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 40)

    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

entity.onMobEngage = function(mob)
    handleRegen(mob, mob:getAnimationSub())
end

entity.onMobFight = function(mob, target)
    handleRegen(mob, mob:getAnimationSub())
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList = {}
    local skillInfo =
    {
        [1] = { xi.mobSkill.TREMBLING,       100, 2, true,  true  },
        [2] = { xi.mobSkill.SERPENTINE_TAIL, 100, 2, true,  false },
        [3] = { xi.mobSkill.BAROFIELD,       100, 2, false, true  },
        [4] = { xi.mobSkill.NERVE_GAS,        50, 0, true,  true  },
        [5] = { xi.mobSkill.PYRIC_BULWARK,   100, 0, true,  true  },
        [6] = { xi.mobSkill.PYRIC_BLAST,     100, 0, false, true  },
        [7] = { xi.mobSkill.POLAR_BULWARK,   100, 1, true,  true  },
        [8] = { xi.mobSkill.POLAR_BLAST,     100, 1, false, true  },
    }

    local hpp         = mob:getHPP()
    local brokenHeads = mob:getAnimationSub()
    local isInFront   = target:isInfront(mob, 128)
    local isBehind    = target:isBehind(mob, 128)

    for i = 1, #skillInfo do
        if
            hpp <= skillInfo[i][2] and
            brokenHeads <= skillInfo[i][3] and
            (skillInfo[i][4] or isInFront) and
            (skillInfo[i][5] or isBehind)
        then
            table.insert(skillList, skillInfo[i][1])
        end
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.enemyLeaderKill(mob)
        xi.nyzul.vigilWeaponDrop(player, mob)
        xi.nyzul.handleRunicKey(mob)
    end
end

return entity
