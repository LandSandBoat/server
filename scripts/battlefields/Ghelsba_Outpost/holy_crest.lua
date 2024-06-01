-----------------------------------
-- Holy Crest
-- Ghelsba Outpost DRG quest battlefield
-- !pos -162 -11 78 140
-----------------------------------
local ghelsbaID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.GHELSBA_OUTPOST,
    battlefieldId = xi.battlefield.id.HOLY_CREST,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 1,
    area          = 1,
    entryNpc      = 'Hut_Door',
    questArea     = xi.questLog.SANDORIA,
    quest         = xi.quest.id.sandoria.THE_HOLY_CREST,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
end

function content:onEventFinishWin(player, csid, option, npc)
    if
        option ~= 0 and
        player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
    then
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST, {
            title = xi.title.HEIR_TO_THE_HOLY_CREST,
            var   = 'TheHolyCrest_Event',
        })

        player:delKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        player:unlockJob(xi.job.DRG)
        player:messageSpecial(ghelsbaID.text.YOU_CAN_NOW_BECOME_A_DRAGOON)
        player:setPetName(xi.petType.WYVERN, option + 1)
    end
end

content.groups =
{
    {
        mobIds =
        {
            ghelsbaID.mob.CYRANUCE_M_CUTAULEON,
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
