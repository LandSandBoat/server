-----------------------------------
-- Area: Navukgo Execution Chamber
-- BCNM: Omens
-----------------------------------
local navukgoID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    battlefieldId    = xi.battlefield.id.OMENS,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    entryNpc         = '_1s0',
    exitNpcs         = { '_1s1', '_1s2', '_1s3' },

    questArea     = xi.questLog.AHT_URHGAN,
    quest         = xi.quest.id.ahtUrhgan.OMENS,
    requiredVar   = 'Quest[6][22]Prog',
    requiredValue = 0,
})

function content:battlefieldEntry(player, battlefield)
    local additionalEntered = battlefield:getPlayerCount() - 1

    -- First Flan is spawned by default and for every 3 members entering
    -- after, and additional flan is spawned.  This will be called on every
    -- entry, so we _should_ be guaranteed to hit every incremented value.
    -- mobIdOffset is additive, with the initial mob spawn at a 0-value.

    if
        additionalEntered > 0 and
        additionalEntered % 3 == 0
    then
        local battlefieldArea = battlefield:getArea()
        local mobOffset       = math.floor(additionalEntered / 3)
        local flanObj         = GetMobByID(navukgoID.mob.IMMORTAL_FLAN + (battlefieldArea - 1) * 7 + mobOffset)

        if not flanObj:isSpawned() then
            flanObj:spawn()
            battlefield:setLocalVar('numSpawned', mobOffset)
        end
    end
end

local handleDeath = function(battlefield, mob)
    local mobIdOffset = navukgoID.mob.IMMORTAL_FLAN + (battlefield:getArea() - 1) * 7

    for mobId = mobIdOffset, mobIdOffset + battlefield:getLocalVar('numSpawned') do
        local mobObj = GetMobByID(mobId)

        if
            mobObj:isSpawned() and
            not mobObj:isDead()
        then
            return
        end
    end

    battlefield:setStatus(xi.battlefield.status.WON)
end

content.groups =
{
    {
        mobIds =
        {
            { navukgoID.mob.IMMORTAL_FLAN      },
            { navukgoID.mob.IMMORTAL_FLAN + 7  },
            { navukgoID.mob.IMMORTAL_FLAN + 14 },
        },

        superlinkGroup = 1,
        death          = handleDeath,
    },

    {
        mobIds =
        {
            {
                navukgoID.mob.IMMORTAL_FLAN + 1,
                navukgoID.mob.IMMORTAL_FLAN + 2,
                navukgoID.mob.IMMORTAL_FLAN + 3,
                navukgoID.mob.IMMORTAL_FLAN + 4,
                navukgoID.mob.IMMORTAL_FLAN + 5,
            },

            {
                navukgoID.mob.IMMORTAL_FLAN + 8,
                navukgoID.mob.IMMORTAL_FLAN + 9,
                navukgoID.mob.IMMORTAL_FLAN + 10,
                navukgoID.mob.IMMORTAL_FLAN + 11,
                navukgoID.mob.IMMORTAL_FLAN + 12,
            },

            {
                navukgoID.mob.IMMORTAL_FLAN + 15,
                navukgoID.mob.IMMORTAL_FLAN + 16,
                navukgoID.mob.IMMORTAL_FLAN + 17,
                navukgoID.mob.IMMORTAL_FLAN + 18,
                navukgoID.mob.IMMORTAL_FLAN + 19,
            },
        },

        spawned        = false,
        superlinkGroup = 1,
        death          = handleDeath,
    },
}

return content:register()
