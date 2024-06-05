-----------------------------------
-- Waking Dreams
-- The Shrouded Maw avatar battlefield
-- !addkeyitem VIAL_OF_DREAM_INCENSE
-----------------------------------
local shroudedMawID = zones[xi.zone.THE_SHROUDED_MAW]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.THE_SHROUDED_MAW,
    battlefieldId    = xi.battlefield.id.WAKING_DREAMS,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'MC_Entrance',
    exitNpc          = 'Memento_Circle',
    requiredKeyItems = { xi.ki.VIAL_OF_DREAM_INCENSE },

    questArea = xi.questLog.WINDURST,
    quest     = xi.quest.id.windurst.WAKING_DREAMS,
})

function content:setupBattlefield(battlefield)
    local tileOffset = shroudedMawID.npc.DARKNESS_NAMED_TILE_OFFSET + (battlefield:getArea() - 1) * 8

    for tileId = tileOffset, tileOffset + 7 do
        GetNPCByID(tileId):setAnimation(xi.anim.CLOSE_DOOR)
    end
end

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_DREAMS)
    player:addTitle(xi.title.HEIR_TO_THE_REALM_OF_DREAMS)
end

content.groups =
{
    {
        mobIds =
        {
            { shroudedMawID.mob.DIABOLOS + 27 },
            { shroudedMawID.mob.DIABOLOS + 34 },
            { shroudedMawID.mob.DIABOLOS + 41 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                shroudedMawID.mob.DIABOLOS + 28,
                shroudedMawID.mob.DIABOLOS + 29,
                shroudedMawID.mob.DIABOLOS + 30,
                shroudedMawID.mob.DIABOLOS + 31,
                shroudedMawID.mob.DIABOLOS + 32,
                shroudedMawID.mob.DIABOLOS + 33,
            },

            {
                shroudedMawID.mob.DIABOLOS + 35,
                shroudedMawID.mob.DIABOLOS + 36,
                shroudedMawID.mob.DIABOLOS + 37,
                shroudedMawID.mob.DIABOLOS + 38,
                shroudedMawID.mob.DIABOLOS + 39,
                shroudedMawID.mob.DIABOLOS + 40,
            },

            {
                shroudedMawID.mob.DIABOLOS + 42,
                shroudedMawID.mob.DIABOLOS + 43,
                shroudedMawID.mob.DIABOLOS + 44,
                shroudedMawID.mob.DIABOLOS + 45,
                shroudedMawID.mob.DIABOLOS + 46,
                shroudedMawID.mob.DIABOLOS + 47,
            },
        },

        superlink = true,
    },
}

return content:register()
