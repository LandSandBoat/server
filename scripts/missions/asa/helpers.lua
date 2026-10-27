-----------------------------------
-- A Shantotto Ascension Helpers
-----------------------------------
xi = xi or {}
xi.asa = xi.asa or {}
xi.asa.helpers = xi.asa.helpers or {}

xi.asa.helpers.countKeyItems = function(player, keyItems)
    local count = 0
    for _, keyItem in ipairs(keyItems) do
        if player:hasKeyItem(keyItem) then
            count = count + 1
        end
    end

    return count
end

xi.asa.helpers.delKeyItems = function(player, keyItems)
    for _, keyItem in ipairs(keyItems) do
        player:delKeyItem(keyItem)
    end
end

-----------------------------------
-- ASA-4: Sugar-Coated Directive
-----------------------------------

-- A local var, so the protocrystal refuses the seal again after every zone in, as observed on retail.
xi.asa.helpers.sugarCoatedStymiedVar = '[ASA]Stymied'

-- winVar outlives the zone, since the player may leave before attaching the seal.
xi.asa.helpers.sugarCoated =
{
    [xi.zone.CLOISTER_OF_FLAMES] =
    {
        seal        = xi.keyItem.DOMINAS_SCARLET_SEAL,
        counterseal = xi.keyItem.SCARLET_COUNTERSEAL,
        winVar      = '[ASA]IfritWin',
        astralFlows = { xi.mobSkill.INFERNO_1, xi.mobSkill.INFERNO_4 },
    },

    [xi.zone.CLOISTER_OF_FROST] =
    {
        seal        = xi.keyItem.DOMINAS_AZURE_SEAL,
        counterseal = xi.keyItem.AZURE_COUNTERSEAL,
        winVar      = '[ASA]ShivaWin',
        astralFlows = { xi.mobSkill.DIAMOND_DUST_1, xi.mobSkill.DIAMOND_DUST_4 },
    },

    [xi.zone.CLOISTER_OF_GALES] =
    {
        seal        = xi.keyItem.DOMINAS_EMERALD_SEAL,
        counterseal = xi.keyItem.EMERALD_COUNTERSEAL,
        winVar      = '[ASA]GarudaWin',
        astralFlows = { xi.mobSkill.AERIAL_BLAST_1, xi.mobSkill.AERIAL_BLAST_4 },
    },

    [xi.zone.CLOISTER_OF_STORMS] =
    {
        seal        = xi.keyItem.DOMINAS_VIOLET_SEAL,
        counterseal = xi.keyItem.VIOLET_COUNTERSEAL,
        winVar      = '[ASA]RamuhWin',
        astralFlows = { xi.mobSkill.JUDGMENT_BOLT_1, xi.mobSkill.JUDGMENT_BOLT_4 },
    },

    [xi.zone.CLOISTER_OF_TIDES] =
    {
        seal        = xi.keyItem.DOMINAS_CERULEAN_SEAL,
        counterseal = xi.keyItem.CERULEAN_COUNTERSEAL,
        winVar      = '[ASA]LeviathanWin',
        astralFlows = { xi.mobSkill.TIDAL_WAVE_1, xi.mobSkill.TIDAL_WAVE_4 },
    },

    [xi.zone.CLOISTER_OF_TREMORS] =
    {
        seal        = xi.keyItem.DOMINAS_AMBER_SEAL,
        counterseal = xi.keyItem.AMBER_COUNTERSEAL,
        winVar      = '[ASA]TitanWin',
        astralFlows = { xi.mobSkill.EARTHEN_FURY_1, xi.mobSkill.EARTHEN_FURY_4 },
    },
}

-- Entry stays open after the mission for the Bird key repeat. TODO: Squintrox Dryeyes hands out the seals for it.
xi.asa.helpers.sugarCoatedEntry = function(player)
    local current = player:getCurrentMission(xi.mission.log_id.ASA)

    if
        current ~= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
        not player:hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
    then
        return false
    end

    return player:getLocalVar(xi.asa.helpers.sugarCoatedStymiedVar) == 1
end

-- Observed on retail: flows at 80, 60, 40, 20 and 1 percent.
local astralFlowThresholds = { 80, 60, 40, 20, 1 }

-- Observed on retail: the avatar takes about 30 percent damage while pinned at 1 percent.
local floorDamageTakenP = -7000

-- The fifth flow uses the longer skill, and only after it does the avatar become killable.
xi.asa.helpers.astralFlow = function(mob)
    local flow       = mob:getLocalVar('astralflows')
    local floorStage = mob:getLocalVar('astralFloor')

    if mob:getHPP() <= 1 and floorStage == 0 then
        floorStage = 1
        mob:setLocalVar('astralFloor', floorStage)
        mob:addMod(xi.mod.DMG, floorDamageTakenP)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if flow > #astralFlowThresholds then
        if floorStage == 1 then
            mob:setLocalVar('astralFloor', 2)
            mob:delMod(xi.mod.DMG, floorDamageTakenP)
            mob:setUnkillable(false)
        end

        return
    end

    local currentTime = GetSystemTime()
    if
        mob:getHPP() <= astralFlowThresholds[flow] and
        currentTime >= mob:getLocalVar('astralFlowReady')
    then
        local skills = xi.asa.helpers.sugarCoated[mob:getZoneID()].astralFlows
        local skill  = skills[1]
        if flow == #astralFlowThresholds then
            skill = skills[2]
        end

        -- Observed on retail: the flows come at least eight seconds apart.
        mob:setLocalVar('astralflows', flow + 1)
        mob:setLocalVar('astralFlowReady', currentTime + 8)
        mob:useMobAbility(skill)
    end
end
