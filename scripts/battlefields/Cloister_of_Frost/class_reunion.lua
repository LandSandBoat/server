-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Class Reunion
-----------------------------------
local cloisterOfFrostID = zones[xi.zone.CLOISTER_OF_FROST]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FROST,
    battlefieldId    = xi.battlefield.id.CLASS_REUNION,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'IP_Entrance',
    exitNpc          = 'Ice_Protocrystal',
    requiredItems    = { xi.item.ICE_PENDULUM },

    questArea     = xi.questLog.WINDURST,
    quest         = xi.quest.id.windurst.CLASS_REUNION,
    requiredVar   = 'ClassReunionProgress',
    requiredValue = 5,
})

function content:onEventFinishWin(player, csid, option, npc)
    if player:getCharVar('ClassReunionProgress') == 5 then
        player:setCharVar('ClassReunionProgress', 6)
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfFrostID.mob.DRYAD,
                cloisterOfFrostID.mob.DRYAD + 1,
                cloisterOfFrostID.mob.DRYAD + 2,
                cloisterOfFrostID.mob.DRYAD + 3,
                cloisterOfFrostID.mob.DRYAD + 4,
                cloisterOfFrostID.mob.DRYAD + 5,
            },

            {
                cloisterOfFrostID.mob.DRYAD + 6,
                cloisterOfFrostID.mob.DRYAD + 7,
                cloisterOfFrostID.mob.DRYAD + 8,
                cloisterOfFrostID.mob.DRYAD + 9,
                cloisterOfFrostID.mob.DRYAD + 10,
                cloisterOfFrostID.mob.DRYAD + 11,
            },

            {
                cloisterOfFrostID.mob.DRYAD + 12,
                cloisterOfFrostID.mob.DRYAD + 13,
                cloisterOfFrostID.mob.DRYAD + 14,
                cloisterOfFrostID.mob.DRYAD + 15,
                cloisterOfFrostID.mob.DRYAD + 16,
                cloisterOfFrostID.mob.DRYAD + 17,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
