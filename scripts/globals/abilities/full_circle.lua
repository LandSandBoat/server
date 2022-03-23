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
    local fcMerit       = player:getMerit(xi.merit.FULL_CIRCLE_EFFECT)
    local mp_returned   = ((0.5 + (fcMerit /100)) *mp_cost) *hpp_remaining / 100
    local crMerit       = player:getMerit(xi.merit.CURATIVE_RECANTATION)

    if crMerit > 0 then
       player:restoreHP((1.2 *(mp_cost *crMerit) *(hpp_remaining /100)))
    end
    player:restoreMP(mp_returned)
    target:despawnPet()
end

return ability_object
