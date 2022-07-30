-----------------------------------
-- Summoner Job Utilities
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/jobpoints")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.summoner = xi.job_utils.summoner or {}
-----------------------------------

-- sort of a misnomer, as if Apogee is up, the "base" mp cost rises.
local function getBaseMPCost(player, abilityId)
    local baseMPCostMap =
    {
        -- Siren
        [xi.jobAbility.WELT] = 9,
    }
    local baseMPCost = baseMPCostMap[abilityId]

    if baseMPCost == nil then
        printf("[warning] scripts/globals/job_utils/summoner.lua::getBaseMPCost(): MP cost for xi.jobAbility with id %d not implemented.", abilityId)
        return 9999
    end

    -- https://www.bg-wiki.com/ffxi/Apogee
    -- Apogee, 1.5x MP cost, don't delete effect here because we need to reset BP: Ward/Rage timer upon use
    if player:hasStatusEffect(xi.effect.APOGEE) then
        baseMPCost = baseMPCost * 1.5
    end

    return baseMPCost
end

local function getMPCost(baseMPCost, player, petskill)

    local mpCost = baseMPCost

    -- don't proc blood boon on Astral Flow
    if petskill:getAddType() ~= xi.addType.ADDTYPE_ASTRAL_FLOW then
        local bloodBoonRate = player:getMod(xi.mod.BLOOD_BOON)
        -- assuming it works like Conserve MP... https://www.bg-wiki.com/ffxi/Conserve_MP
        if math.random(100) < bloodBoonRate then
            mpCost = mpCost * math.random(8, 15) / 16
        end
    end

    return mpCost
end

xi.job_utils.summoner.canUseBloodPact = function(player, pet, target, ability)

    -- TODO: verify order of out of MP/range/etc checks.
    if pet ~= nil then
        -- There is some complex interaction here.
        -- First off, you will get out of range message if the pet isn't within the abilities range to it's target.
        -- Second, if your pet is in range, but you're out of range of your pet, retail provides no message for some reason but the pet does nothing.
        -- No out of range error message is unhelpful so we are setting that message anyway.

        -- TODO: The hardcoded ranges of 21/22 need to take into account mob size.
        -- TODO: add "era" setting or setting in general for this. Era used to have a smaller range for BPs.
        -- This is a "new" change -- https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
        -- TODO: verify who/what is "out of range" for out of range messages

        -- check if target is too far from pet for ability
        if pet:checkDistance(target) >= ability:getRange() then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        -- check if player is too far from pet
        if pet:checkDistance(player) >= 21 then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        -- check if player is too far from target
        if target:checkDistance(player) >= 22 then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        local baseMPCost = getBaseMPCost(player, ability:getID())

        if player:getMP() < baseMPCost then
            return xi.msg.basic.UNABLE_TO_USE_JA2, 0 -- TODO: verify exact message in packet.
        end

        return 0, 0
    end

    return xi.msg.basic.UNABLE_TO_USE_JA2, 0 -- TODO: verify exact message in packet.
end

xi.job_utils.onUseBloodPact = function(player, pet, target, petskill)

    local bloodPactAbility = GetAbility(petskill:getID()) -- Player abilities and Avatar abilities are mapped 1:1

    local baseMPCost = getBaseMPCost(player, bloodPactAbility:getID())
    local mpCost = getMPCost(baseMPCost, player, bloodPactAbility)

    if player:hasStatusEffect(xi.effect.APOGEE) then
        player:resetRecast(xi.recast.ABILITY, bloodPactAbility:getRecastID())
        player:delStatusEffect(xi.effect.APOGEE)
    end

    player:delMP(mpCost)
end
