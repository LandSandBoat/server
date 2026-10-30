-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: D. Shantotto
-- BCNM: Project: Shantottofication (ASA-13)
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local ID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Shantotto sits one id below her. TODO: Capture needed, she was not seen below 10 percent with a line of her own.
local rage =
{
    animation     = 439,
    action        = xi.mobSkill.SUBSTITUTE,
    meteor        = ID.text.D_SHANTOTTO_BOW_BEFORE_MIGHT,
    partnerOffset = -1,
    thresholds    =
    {
        { hpp = 75, message = ID.text.D_SHANTOTTO_CURSE        },
        { hpp = 50, message = ID.text.D_SHANTOTTO_NO_QUARTER   },
        { hpp = 25, message = ID.text.D_SHANTOTTO_SLOW_OR_FAST },
        { hpp = 10, meteor = true },
    },
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('rageStage', 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.D_SHANTOTTO_WELCOME)
end

entity.onMobFight = function(mob, target)
    xi.asa.helpers.onSisterFight(mob, target, rage)
end

entity.onMobDisengage = function(mob)
    xi.asa.helpers.onSisterDisengage(mob, ID.text.D_SHANTOTTO_VICTORY)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.D_SHANTOTTO_DEFEATED)
    end
end

return entity
