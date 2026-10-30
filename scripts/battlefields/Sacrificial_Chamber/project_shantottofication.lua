-----------------------------------
-- Area: Sacrificial Chamber
-- Name: A Shantotto Ascension Mission 13, Project: Shantottofication
-- !pos 300 -1.85 355 163
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local sacrificialChamberID = zones[xi.zone.SACRIFICIAL_CHAMBER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.SACRIFICIAL_CHAMBER,
    battlefieldId = xi.battlefield.id.PROJECT_SHANTOTTOFICATION,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 3,
    entryNpc      = '_4j0',
    exitNpcs      = { '_4j2', '_4j3', '_4j4' },
    missionArea   = xi.mission.log_id.ASA,
    mission       = xi.mission.id.asa.PROJECT_SHANTOTTOFICATION,

    grantXP = 750,
})

-- The stats and resistances each tablet raises.
local tabletStatMods =
{
    xi.mod.STR,
    xi.mod.DEX,
    xi.mod.VIT,
    xi.mod.AGI,
    xi.mod.INT,
    xi.mod.MND,
    xi.mod.CHR,
    xi.mod.FIRE_MEVA,
    xi.mod.ICE_MEVA,
    xi.mod.WIND_MEVA,
    xi.mod.EARTH_MEVA,
    xi.mod.THUNDER_MEVA,
    xi.mod.WATER_MEVA,
}

-- Holding the Tonberry key refuses entry. TODO: Capture needed, retail was only seen with all sixteen tablets.
function content:entryRequirement(player, npc, isRegistrant, trade)
    if player:hasKeyItem(xi.keyItem.TONBERRY_KEY) then
        player:messageSpecial(sacrificialChamberID.text.CANNOT_ENTER_WITH_KEY, xi.keyItem.TONBERRY_KEY)
        return false
    end

    return xi.asa.helpers.countKeyItems(player, xi.asa.helpers.tabletsOfHexes) > 0
end

-- The fight stays open after the mission for another Tonberry key.
function content:checkRequirements(player, npc, isRegistrant, trade)
    if not Battlefield.checkRequirements(self, player, npc, isRegistrant, trade) then
        return false
    end

    return player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.PROJECT_SHANTOTTOFICATION or
        player:hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)
end

function content:onBattlefieldEnter(player, battlefield)
    local door = GetNPCByID(sacrificialChamberID.npc.MAHOGANY_DOOR)
    if door then
        player:messageText(door, sacrificialChamberID.text.ABSORB_ANCIENT_RUNES)
    end

    BattlefieldMission.onBattlefieldEnter(self, player, battlefield)

    player:setLocalVar('asaTabletsPending', xi.asa.helpers.countKeyItems(player, xi.asa.helpers.tabletsOfHexes))
end

-- The mods ride on the Battlefield effect, which non-registrants only get after onBattlefieldEnter.
function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    for _, player in pairs(battlefield:getPlayers()) do
        local tablets = player:getLocalVar('asaTabletsPending')
        local effect  = player:getStatusEffect(xi.effect.BATTLEFIELD)
        if tablets ~= 0 and effect then
            player:setLocalVar('asaTabletsPending', 0)
            xi.asa.helpers.delKeyItems(player, xi.asa.helpers.tabletsOfHexes)

            -- The wiki gives all sixteen tablets +150 to every stat and resistance, triple HP and MP and a Reraise.
            -- TODO: Capture needed, the per-tablet split is a guess.
            local statBonus = math.floor(150 * tablets / 16)
            local poolBonus = math.floor(200 * tablets / 16)

            for _, mod in ipairs(tabletStatMods) do
                effect:addMod(mod, statBonus)
            end

            effect:addMod(xi.mod.HPP, poolBonus)
            effect:addMod(xi.mod.MPP, poolBonus)
            player:updateHealth()
            player:addStatusEffect(xi.effect.RERAISE, { power = 3, duration = utils.minutes(30), origin = player })
        end
    end
end

function content:onEventFinishWin(player, csid, option, npc)
    BattlefieldMission.onEventFinishWin(self, player, csid, option, npc)

    npcUtil.giveKeyItem(player, xi.keyItem.TONBERRY_KEY)

    if player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.PROJECT_SHANTOTTOFICATION then
        npcUtil.completeMission(player, xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION,
        {
            nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE },
        })
    end
end

content.groups =
{
    {
        mobs           = { 'Shantotto', 'D_Shantotto' },
        superlinkGroup = 1,
        allDeath       = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
