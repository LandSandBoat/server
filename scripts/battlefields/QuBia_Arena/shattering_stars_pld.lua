-----------------------------------
-- Area: Qu'Bia Arena
-- Name: Shattering Stars - Maat Fight (PLD)
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.QUBIA_ARENA,
    battlefieldId = xi.battlefield.id.SHATTERING_STARS_PLD,
    maxPlayers    = 1,
    levelCap      = 99,
    allowSubjob   = false,
    timeLimit     = utils.minutes(10),
    index         = 5,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
    requiredItems = { xi.item.PALADINS_TESTIMONY, wearMessage = qubiaID.text.TESTIMONY_WEARS, wornMessage = qubiaID.text.TESTIMONY_IS_TORN },
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) >= xi.questStatus.QUEST_ACCEPTED and
        player:getMainJob() == xi.job.PLD and
        player:getMainLvl() >= 66
end

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.MAAT     },
            { qubiaID.mob.MAAT + 1 },
            { qubiaID.mob.MAAT + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
