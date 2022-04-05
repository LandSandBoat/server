-----------------------------------
-- Ability: Full Circle
-- Causes your luopan to vanish.
-- Obtained: Geomancer Level 5
-- Recast Time: 10 seconds
-- Refunds some of the MP consumed by the Geocolure spell that created the luopan.
-- Amount of MP restored varies depending on remaining Luopan HP.
-----------------------------------
require("scripts/globals/job_utils/geomancer")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/settings/main")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnAbilityCheck(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    local luopan        = player:getPet()
    local hpp_remaining = luopan:getHPP()
    local mp_cost       = luopan:getLocalVar("MP_COST")
    local fc_merit      = player:getMerit(xi.merit.FULL_CIRCLE_EFFECT)
    local cr_merit      = player:getMerit(xi.merit.CURATIVE_RECANTATION)
    local fc_mod        = player:getMod(xi.mod.FULL_CIRCLE)
    local cr_mod        = player:getMod(xi.mod.CURATIVE_RECANTATION)
    local mp_multiplier = 0.5 + (fc_merit / 10) + (fc_mod / 10)
    local hp_multiplier = 0.5 + (0.7 * cr_merit) + (cr_mod / 10)
    local mp_returned   = 0
    local hp_returned   = 0

    -- calculate final mp value
    mp_returned = math.floor((mp_multiplier * mp_cost) * (hpp_remaining / 100))

    if cr_merit > 0 then
        -- calculate final hp value
        hp_returned = math.floor((hp_multiplier * mp_cost) * (hpp_remaining /100))
        player:restoreHP(hp_returned)
    end

    player:restoreMP(mp_returned)
    target:despawnPet()
end

return ability_object
