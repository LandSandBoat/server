-----------------------------------
-- Dancer Job Utilities
-----------------------------------
require('scripts/globals/msg')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dancer = xi.job_utils.dancer or {}
-----------------------------------

xi.dancer.stepAbilityCheck = function(player, target, ability)
    if player:getAnimation() ~= 1 then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    else
        if player:hasStatusEffect(xi.effect.TRANCE) then
            return 0, 0
        elseif player:getTP() < 100 then
            return xi.msg.basic.NOT_ENOUGH_TP, 0
        else
            return 0, 0
        end
    end
end
