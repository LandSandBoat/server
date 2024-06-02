-----------------------------------
-- Area: Sealion's Den
-- Name: One to be Feared
-----------------------------------
local sealionsDenID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.SEALIONS_DEN,
    battlefieldId = xi.battlefield.id.ONE_TO_BE_FEARED,
    isMission     = true,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = '_0w0',
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.ONE_TO_BE_FEARED,
    requiredVar   = 'Mission[6][638]Status',
    requiredValue = 3,

    grantXP = 1500,
    title   = xi.title.ULTIMA_UNDERTAKER,
})

-- NOTE: Mob spawning for phase changes in this battlefield is triggered
-- by the airship door, which is also the battlefield exit.  Exit has been
-- purposefully omitted from this to allow that function.

local function healCharacter(player)
    if player:isAlive() then
        player:setHP(player:getMaxHP())
        player:setMP(player:getMaxMP())
        player:setTP(0)

        if player:getPet() ~= nil then
            local pet = player:getPet()
            pet:setHP(pet:getMaxHP())
            pet:setMP(pet:getMaxMP())
            pet:setTP(0)
        end
    end
end

local function returnToAirship(player)
    local battlefieldArea = player:getBattlefield():getArea()

    if battlefieldArea == 1 then
        player:setPos(-780.010, -103.348, -86.327, 193)
    elseif battlefieldArea == 2 then
        player:setPos(-140.029, -23.348, -446.376, 193)
    elseif battlefieldArea == 3 then
        player:setPos(499.969, 56.652, -806.132, 193)
    end

    if player:isDead() then
        player:allowSendRaisePrompt()
    end
end

function content:onEventFinishBattlefield(player, csid, option, npc)
    if csid == 10 then
        player:addTitle(xi.title.BRANDED_BY_LIGHTNING)
        healCharacter(player)
        returnToAirship(player)

        player:setLocalVar('[OTBF]battleCompleted', 1)
    elseif csid == 11 then
        player:addTitle(xi.title.OMEGA_OSTRACIZER)
        healCharacter(player)
        returnToAirship(player)

        player:setLocalVar('[OTBF]battleCompleted', 2)
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                sealionsDenID.mob.MAMMET_22_ZETA,
                sealionsDenID.mob.MAMMET_22_ZETA + 1,
                sealionsDenID.mob.MAMMET_22_ZETA + 2,
                sealionsDenID.mob.MAMMET_22_ZETA + 3,
                sealionsDenID.mob.MAMMET_22_ZETA + 4,
            },

            {
                sealionsDenID.mob.MAMMET_22_ZETA + 7,
                sealionsDenID.mob.MAMMET_22_ZETA + 8,
                sealionsDenID.mob.MAMMET_22_ZETA + 9,
                sealionsDenID.mob.MAMMET_22_ZETA + 10,
                sealionsDenID.mob.MAMMET_22_ZETA + 11,
            },

            {
                sealionsDenID.mob.MAMMET_22_ZETA + 14,
                sealionsDenID.mob.MAMMET_22_ZETA + 15,
                sealionsDenID.mob.MAMMET_22_ZETA + 16,
                sealionsDenID.mob.MAMMET_22_ZETA + 17,
                sealionsDenID.mob.MAMMET_22_ZETA + 18,
            },
        },

        allDeath = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(10)
            end
        end,
    },

    {
        mobIds =
        {
            { sealionsDenID.mob.MAMMET_22_ZETA + 5  },
            { sealionsDenID.mob.MAMMET_22_ZETA + 12 },
            { sealionsDenID.mob.MAMMET_22_ZETA + 19 },
        },

        spawned  = false,
        allDeath = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(11)
            end
        end,
    },

    {
        mobIds =
        {
            { sealionsDenID.mob.MAMMET_22_ZETA + 6  },
            { sealionsDenID.mob.MAMMET_22_ZETA + 13 },
            { sealionsDenID.mob.MAMMET_22_ZETA + 20 },
        },

        spawned  = false,
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
