-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Waking the Beast
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FROST,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FROST,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 3,
    entryNpc         = 'IP_Entrance',
    exitNpc          = 'Ice_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FROST)
end

content.groups =
{
    {
        mobs = { 'Shiva_Prime_WTB' },
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
            'Shiva_Prime_WTB',
            'Ice_Elemental',
        },
        isParty   = true,
        superlink = true,
    },
}

return content:register()
