-----------------------------------
-- Area: Cloister of Flames
-- BCNM: Waking the Beast
-----------------------------------
local cloisterOfFlamesID = zones[xi.zone.CLOISTER_OF_FLAMES]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_FLAMES,
    battlefieldId    = xi.battlefield.id.WAKING_THE_BEAST_CLOISTER_OF_FLAMES,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = 'FP_Entrance',
    exitNpc          = 'Fire_Protocrystal',
    requiredKeyItems = { xi.ki.RAINBOW_RESONATOR },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.WAKING_THE_BEAST,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveKeyItem(player, xi.ki.EYE_OF_FLAMES)
end

content.groups =
{
    {
        -- avatar
        mobIds =
        {
            { cloisterOfFlamesID.mob.IFRIT_PRIME_WTB      },
            { cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 5  },
            { cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 10 },
        },

        allDeath = function(battlefield, mob)
            -- when avatar defeated then all elementals should also die
            for i = 1, 4 do
                local elemental = GetMobByID(mob:getID() + i)
                if elemental:isAlive() then
                    elemental:setHP(0)
                end
            end

            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        -- elementals
        mobIds =
        {
            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 1,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 2,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 3,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 4,
            },

            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 6,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 7,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 8,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 9,
            },

            {
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 11,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 12,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 13,
                cloisterOfFlamesID.mob.IFRIT_PRIME_WTB + 14,
            },
        },
    },
}

return content:register()
