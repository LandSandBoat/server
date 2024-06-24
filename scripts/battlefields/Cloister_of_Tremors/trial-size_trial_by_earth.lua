-----------------------------------
-- Area: Cloister of Tremors
-- BCNM: Trial-size Trial by Earth
-----------------------------------
local cloisterOfTremorsID = zones[xi.zone.CLOISTER_OF_TREMORS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TREMORS,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_EARTH,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'EP_Entrance',
    exitNpc          = 'Earth_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_EARTH },

    questArea = xi.questLog.BASTOK,
    quest     = xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfTremorsID.mob.TITAN_PRIME + 6 },
            { cloisterOfTremorsID.mob.TITAN_PRIME + 7 },
            { cloisterOfTremorsID.mob.TITAN_PRIME + 8 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
