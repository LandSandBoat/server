-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Shantotto
-- BCNM: Project: Shantottofication (ASA-13)
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local ID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------
---@type TMobEntity
local entity = {}

-- D. Shantotto sits one id above her.
local rage =
{
    animation     = 438,
    action        = xi.mobSkill.VULTURE_4,
    meteor        = ID.text.SHANTOTTO_PANTS_ALIGHT,
    partnerOffset = 1,
    thresholds    =
    {
        { hpp = 75, message = ID.text.SHANTOTTO_BEG_TO_DIE    },
        { hpp = 50, message = ID.text.SHANTOTTO_OVERSTAYED    },
        { hpp = 25, message = ID.text.SHANTOTTO_NEVER_BORN    },
        { hpp = 10, message = ID.text.SHANTOTTO_WICKED_FRIGHT, meteor = true },
    },
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('rageStage', 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.SHANTOTTO_BREAD)
end

entity.onMobFight = function(mob, target)
    xi.asa.helpers.onSisterFight(mob, target, rage)
end

entity.onMobDisengage = function(mob)
    xi.asa.helpers.onSisterDisengage(mob, ID.text.SHANTOTTO_VICTORY)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.SHANTOTTO_DEFEATED)
    end
end

return entity
