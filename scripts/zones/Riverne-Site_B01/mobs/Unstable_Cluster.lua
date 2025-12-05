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

    local animationSub = mob:getAnimationSub()
    local mobHPP       = mob:getHPP()

    switch (animationSub) : caseof
    {
        [3] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 66 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_3)
            end
        end,

        [4] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 66 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_3)
            end
        end,

        [5] = function()
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            if mobHPP < 33 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_2)
            end
        end,

        [6] = function()
            if mobHPP < 20 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_1_DEATH)
            end
        end,
    }

    return tpList[math.random(1, #tpList)]
end

return entity
