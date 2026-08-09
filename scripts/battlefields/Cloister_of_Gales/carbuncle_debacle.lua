-----------------------------------
-- Area: Cloister of Gales
-- BCNM: Carbuncle Debacle
-----------------------------------
local cloisterOfGalesID = zones[xi.zone.CLOISTER_OF_GALES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_GALES,
    battlefieldId    = xi.battlefield.id.CARBUNCLE_DEBACLE_CLOISTER_OF_GALES,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Wind_Protocrystal',
    requiredItems    = { xi.item.WIND_PENDULUM, keep = true }, -- Wind Pendulum is not consumed on entry, but is required to enter the battlefield.

    questArea     = xi.questLog.WINDURST,
    quest         = xi.quest.id.windurst.CARBUNCLE_DEBACLE,
    requiredVar   = 'CarbuncleDebacleProgress',
    requiredValue = 6,
})

-- Only the battlefield registrant needs to have the required item and quest state to initiate the battlefield.
function content:checkRequirements(player, npc, isRegistrant, trade)
    if isRegistrant then
        return BattlefieldQuest.checkRequirements(self, player, npc, isRegistrant, trade)
    end

    return self:isValidEntry(player, npc)
end

function content:onEventFinishWin(player, csid, option, npc)
    if player:getCharVar('CarbuncleDebacleProgress') == 6 then
        player:setCharVar('CarbuncleDebacleProgress', 7)
    end

    player:delKeyItem(xi.ki.DAZE_BREAKER_CHARM)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfGalesID.mob.OGMIOS     },
            { cloisterOfGalesID.mob.OGMIOS + 1 },
            { cloisterOfGalesID.mob.OGMIOS + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
