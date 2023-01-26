-----------------------------------
--  PET: Wyvern
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/job_utils/dragoon")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
-----------------------------------
local entity = {}

local wyvernCapabilities =
{
    OFFENSIVE = 1,
    DEFENSIVE = 2,
    MULTI     = 3,
}

local wyvernTypes =
{
    [xi.job.WAR] = wyvernCapabilities.OFFENSIVE,
    [xi.job.MNK] = wyvernCapabilities.OFFENSIVE,
    [xi.job.WHM] = wyvernCapabilities.DEFENSIVE,
    [xi.job.BLM] = wyvernCapabilities.DEFENSIVE,
    [xi.job.RDM] = wyvernCapabilities.DEFENSIVE,
    [xi.job.THF] = wyvernCapabilities.OFFENSIVE,
    [xi.job.PLD] = wyvernCapabilities.MULTI,
    [xi.job.DRK] = wyvernCapabilities.MULTI,
    [xi.job.BST] = wyvernCapabilities.OFFENSIVE,
    [xi.job.BRD] = wyvernCapabilities.MULTI,
    [xi.job.RNG] = wyvernCapabilities.OFFENSIVE,
    [xi.job.SAM] = wyvernCapabilities.OFFENSIVE,
    [xi.job.NIN] = wyvernCapabilities.MULTI,
    [xi.job.DRG] = wyvernCapabilities.OFFENSIVE,
    [xi.job.SMN] = wyvernCapabilities.DEFENSIVE,
    [xi.job.BLU] = wyvernCapabilities.DEFENSIVE,
    [xi.job.COR] = wyvernCapabilities.OFFENSIVE,
    [xi.job.PUP] = wyvernCapabilities.OFFENSIVE,
    [xi.job.DNC] = wyvernCapabilities.OFFENSIVE,
    [xi.job.SCH] = wyvernCapabilities.DEFENSIVE,
    [xi.job.GEO] = wyvernCapabilities.DEFENSIVE,
    [xi.job.RUN] = wyvernCapabilities.MULTI,
}

local function doHealingBreath(player, threshold)
    local breathHealRange = 14

    local healingbreath = xi.jobAbility.HEALING_BREATH

    if player:getMainLvl() >= 80 then
        healingbreath = xi.jobAbility.HEALING_BREATH_IV
    elseif player:getMainLvl() >= 40 then
        healingbreath = xi.jobAbility.HEALING_BREATH_III
    elseif player:getMainLvl() >= 20 then
        healingbreath = xi.jobAbility.HEALING_BREATH_II
    end

    -- zone ID check? is this some strange master zoning but pet hasn't despawned in the other zone check?
    local function inBreathRange(target)
        return player:getPet():getZoneID() == target:getZoneID() and player:getPet():checkDistance(target) <= breathHealRange
    end

    if
        player:getHPP() <= threshold and
        inBreathRange(player)
    then
        player:getPet():useJobAbility(healingbreath, player)
    else
        local party = player:getPartyWithTrusts()
        for _, member in pairs(party) do
            if
                member:getHPP() <= threshold and
                inBreathRange(member) and
                not member:isDead()
            then
                player:getPet():useJobAbility(healingbreath, member)
                break
            end
        end
    end
end

local function doStatusBreath(target, player)
    local wyvern = player:getPet()
    -- https://forum.square-enix.com/ffxi/threads/22659-dev1108-Job-Adjustments-Dragoon
    local removeBreathTable =
    {
    --  { lvl, ability                      , { statuses            } },
        { 40, xi.jobAbility.REMOVE_PARALYSIS, { xi.effect.PARALYSIS } },
        { 60, xi.jobAbility.REMOVE_CURSE    , { xi.effect.CURSE_I, xi.effect.BANE, xi.effect.DOOM } },
        { 80, xi.jobAbility.REMOVE_DISEASE  , { xi.effect.DISEASE, xi.effect.PLAGUE } },
        { 20, xi.jobAbility.REMOVE_BLINDNESS, { xi.effect.BLINDNESS } },
        {  1, xi.jobAbility.REMOVE_POISON   , { xi.effect.POISON    } },
    }

    for k, v in pairs(removeBreathTable) do
        local minLevel = v[1]
        local ability = v[2]
        local statusEffects = v[3]

        if wyvern:getMainLvl() >= minLevel then
            for _, effect in pairs(statusEffects) do
                if target:hasStatusEffect(effect) then
                    wyvern:useJobAbility(ability, target)
                    return true
                end
            end
        end
    end

    return false
end

entity.onMobSpawn = function(mob)
    local master = mob:getMaster()

    if master:getMod(xi.mod.WYVERN_SUBJOB_TRAITS) > 0 then
        mob:addJobTraits(master:getSubJob(), master:getSubLvl())
    end

    local wyvernType = wyvernTypes[master:getSubJob()]

    if wyvernType == wyvernCapabilities.DEFENSIVE then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            if not doStatusBreath(player, player) then
                local party = player:getParty()
                for _, member in pairs(party) do
                    if doStatusBreath(member, player) then
                        break
                    end
                end
            end
        end)

        master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
            local threshold = 33
            if player:getMod(xi.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                threshold = 50
            end

            doHealingBreath(player, threshold)
        end)
    elseif
        wyvernType == wyvernCapabilities.OFFENSIVE or
        wyvernType == wyvernCapabilities.MULTI
    then
        master:addListener("WEAPONSKILL_USE", "PET_WYVERN_WS", function(player, target, skillid)
            xi.job_utils.dragoon.pickAndUseDamageBreath(player, target)
        end)
    end

    if wyvernType == wyvernCapabilities.MULTI then
        master:addListener("MAGIC_USE", "PET_WYVERN_MAGIC", function(player, target, spell, action)
            local threshold = 25
            if player:getMod(xi.mod.WYVERN_EFFECTIVE_BREATH) > 0 then
                threshold = 33
            end

            doHealingBreath(player, threshold)
        end)
    end

    master:addListener("ATTACK", "PET_WYVERN_ENGAGE", function(player, target, action)
        local pet = player:getPet()
        if pet:getTarget() == nil or target:getID() ~= pet:getTarget():getID() then
            player:petAttack(target)
        end
    end)

    master:addListener("DISENGAGE", "PET_WYVERN_DISENGAGE", function(player)
        player:petRetreat()
    end)

    -- https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Parameter_Increase
    master:addListener("EXPERIENCE_POINTS", "PET_WYVERN_EXP", function(player, exp)
        xi.job_utils.dragoon.addWyvernExp(player, exp)
    end)
end

local function removeWyvernLevels(mob)
    local master  = mob:getMaster()
    local numLvls = mob:getLocalVar("level_Ups")

    if numLvls ~= 0 then
        local wyvernAttributeIncreaseEffectJP = master:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
        local wyvernBonusDA = master:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

        master:delMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLvls)
        master:delMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLvls)
        master:delMod(xi.mod.ATTP, 4 * numLvls)
        master:delMod(xi.mod.DEFP, 4 * numLvls)
        master:delMod(xi.mod.HASTE_ABILITY, 200 * numLvls)
        master:delMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLvls)
        master:delMod(xi.mod.ALL_WSDMG_ALL_HITS, 2 * numLvls)
    end
end

entity.onMobDeath = function(mob, player)
    removeWyvernLevels(mob)

    local master  = mob:getMaster()
    master:removeListener("PET_WYVERN_WS")
    master:removeListener("PET_WYVERN_MAGIC")
    master:removeListener("PET_WYVERN_ENGAGE")
    master:removeListener("PET_WYVERN_DISENGAGE")
    master:removeListener("PET_WYVERN_EXP")
end

entity.onPetLevelRestriction = function(pet)
    removeWyvernLevels(pet)
    pet:setLocalVar("wyvern_exp", 0)
    pet:setLocalVar("level_Ups", 0)
end

return entity
