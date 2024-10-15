-----------------------------------
-- Area: Cloister of Flames
-- BCNM: Trial-size Trial by Fire
-----------------------------------
local cloisterOfFlamesID = zones[xi.zone.CLOISTER_OF_FLAMES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FLAMES,
    battlefieldId    = xi.battlefield.id.TRIAL_SIZE_TRIAL_BY_FIRE,
    canLoseExp       = false,
    maxPlayers       = 1,
    levelCap         = 20,
    timeLimit        = utils.minutes(15),
    index            = 1,
    entryNpc         = 'FP_Entrance',
    exitNpc          = 'Fire_Protocrystal',
    requiredItems    = { xi.item.MINI_TUNING_FORK_OF_FIRE },

    questArea = xi.questLog.OUTLANDS,
    quest     = xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_FIRE,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:getMainJob() == xi.job.SMN and
        player:getMainLvl() >= 20
end

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.IFRIT) then
        player:addSpell(xi.magic.spell.IFRIT)
        player:messageSpecial(cloisterOfFlamesID.text.IFRIT_UNLOCKED, 0, 0, 0)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.WINDURST, 30)
    player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_FIRE)
end

content.groups =
{
    {
        mobs = { 'Ifrit_Prime_TSTBF' },
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
