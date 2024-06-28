-----------------------------------
-- Area: Balga's Dais
-- Name: Shattering stars - Maat Fight (SMN)
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.BALGAS_DAIS,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_SMN,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 7,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.SUMMONERS_TESTIMONY, wearMessage = balgasID.text.TESTIMONY_WEARS, wornMessage = balgasID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) >= xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { balgasID.mob.MAAT + 6  },
            { balgasID.mob.MAAT + 8  },
            { balgasID.mob.MAAT + 10 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            { balgasID.mob.MAAT + 7  },
            { balgasID.mob.MAAT + 9  },
            { balgasID.mob.MAAT + 11 },
        },

        spawned = false,
    },
}

return content:register()
