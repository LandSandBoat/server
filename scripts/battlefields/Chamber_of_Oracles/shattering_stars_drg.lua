-----------------------------------
-- Area: Chamber of Oracles
-- Name: Shattering stars - Maat Fight (DRG)
-----------------------------------
local chamberOfOraclesID = zones[xi.zone.CHAMBER_OF_ORACLES]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.CHAMBER_OF_ORACLES,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_DRG,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 4,
    entryNpc      = 'SC_Entrance',
    exitNpc       = 'Shimmering_Circle',
    requiredItems = { xi.item.DRAGOONS_TESTIMONY, wearMessage = chamberOfOraclesID.text.TESTIMONY_WEARS, wornMessage = chamberOfOraclesID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) >= xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.DRG and
        player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { chamberOfOraclesID.mob.MAAT + 6  },
            { chamberOfOraclesID.mob.MAAT + 8  },
            { chamberOfOraclesID.mob.MAAT + 10 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    -- Wyvern
    {
        mobIds =
        {
            { chamberOfOraclesID.mob.MAAT + 7  },
            { chamberOfOraclesID.mob.MAAT + 9  },
            { chamberOfOraclesID.mob.MAAT + 11 },
        },

        spawned = false,
    },
}

return content:register()
