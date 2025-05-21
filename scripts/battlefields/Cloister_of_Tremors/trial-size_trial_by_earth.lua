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

function content:onEventFinishWin(player, csid, option, npc)
    if not player:hasSpell(xi.magic.spell.TITAN) then
        player:addSpell(xi.magic.spell.TITAN)
        player:messageSpecial(cloisterOfTremorsID.text.TITAN_UNLOCKED, 0, 0, 1)
    end

    if not player:hasItem(xi.item.SCROLL_OF_INSTANT_WARP) then
        npcUtil.giveItem(player, xi.item.SCROLL_OF_INSTANT_WARP)
    end

    player:addFame(xi.fameArea.BASTOK, 30)
    player:completeQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TRIAL_SIZE_TRIAL_BY_EARTH)
end

content.groups =
{
    {
        mobs = { 'Titan_Prime_TSTBE' },
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
