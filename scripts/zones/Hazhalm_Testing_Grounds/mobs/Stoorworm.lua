-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Stoorworm (Einherjar)
-- Notes: Uses Mighty Strikes.
-- Heads regrow 60-90 seconds after being destroyed.
-- Immune to Bind, Paralyze, Gravity
-----------------------------------
mixins =
{
    require('scripts/mixins/families/hydra'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.GRAVITY)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('headRegrowMin', 60)
    mob:setLocalVar('headRegrowMax', 90)
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

return entity
