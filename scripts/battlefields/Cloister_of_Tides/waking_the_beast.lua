-----------------------------------
-- Area: Cloister of Tides
-- BCNM: Waking the Beast
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_TIDES,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_TIDES,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'WP_Entrance',
    exitNpc          = 'Water_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_TIDES)
end

content.groups =
{
    {
        mobs = { 'Leviathan_Prime_WTB' },
        allDeath = function(battlefield, mob)
            -- when avatar defeated then all elementals should also die
            for i = 1, 4 do
                local elemental = GetMobByID(mob:getID() + i)
                if elemental and elemental:isAlive() then
                    elemental:setHP(0)
                end
            end

            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobs =
        {
            'Leviathan_Prime_WTB',
            'Water_Elemental',
        },
        isParty   = true,
        superlink = true,
    },
}

return content:register()
