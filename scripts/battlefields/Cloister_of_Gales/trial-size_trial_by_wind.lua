-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Trial-size Trial by Wind
-----------------------------------
local cloisterOfGalesID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_GALES,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_WIND,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Wind_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_WIND },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.GARUDA) then
        player:addSpell(xi.magic.spell.GARUDA)
        player:messageSpecial(cloisterOfGalesID.text.GARUDA_UNLOCKED, 0, 0, 3)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.SELBINA_RABAO, 30)
    player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfGalesID.mob.GARUDA_PRIME + 6 },
            { cloisterOfGalesID.mob.GARUDA_PRIME + 7 },
            { cloisterOfGalesID.mob.GARUDA_PRIME + 8 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
