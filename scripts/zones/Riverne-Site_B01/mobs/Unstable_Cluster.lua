-----------------------------------
-- Area: Riverne - Site B01
--   NM: Unstable Cluster
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.REFUELING_1
    }

    local animation = mob:getAnimationSub()
    if animation >= 3 and animation <= 5 then
        table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
        table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
        table.insert(tpList, xi.mobSkill.SLING_BOMB_1)

        if (animation == 3 or animation == 4) and mob:getHPP() < 66 then
            table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_3)
        elseif animation == 5 and mob:getHPP() < 33 then
            table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_2)
        end
    elseif animation == 6 and mob:getHPP() < 20 then
        table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_1_DEATH)
    end

    return tpList[math.random(1, #tpList)]
end

return entity
