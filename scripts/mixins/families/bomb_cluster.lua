-----------------------------------
-- Bomb Cluster Mixin
-- Logic related to mob skill usage
-- Adjusts skills based on how many clusters remain
-- Animation Subs: 3, 4 = Three Clusters, 5 = Two Clusters, 6 = One Cluster
-- TODO: More precise skill selection percentages
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.clusters = xi.mix.clusters or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

xi.mix.clusters.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.REFUELING_1,
    }

    local animation    = mob:getAnimationSub()
    local mobHPP       = mob:getHPP()
    local deathVersion = math.random(1, 100) <= 5

    switch(animation): caseof
    {
        -- CoP Bomb Animations
        [3] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 66 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_3_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_3
                table.insert(tpList, selfDestruct)
            end
        end,

        [4] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 66 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_3_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_3
                table.insert(tpList, selfDestruct)
            end
        end,

        [5] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 33 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_2_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_2
                table.insert(tpList, selfDestruct)
            end
        end,

        [6] = function()
            if mobHPP < 20 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_1_DEATH)
            end
        end,

        -- ToAU Cluster bombs
        [11] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 66 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_3_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_3
                table.insert(tpList, selfDestruct)
            end
        end,

        [12] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 66 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_3_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_3
                table.insert(tpList, selfDestruct)
            end
        end,

        [13] = function()
            table.insert(tpList, xi.mobSkill.SLING_BOMB_1)
            table.insert(tpList, xi.mobSkill.CIRCLE_OF_FLAMES_1)
            table.insert(tpList, xi.mobSkill.FORMATION_ATTACK_1)
            if mobHPP < 33 then
                local selfDestruct = deathVersion and xi.mobSkill.SELF_DESTRUCT_CLUSTER_2_DEATH or xi.mobSkill.SELF_DESTRUCT_CLUSTER_2
                table.insert(tpList, selfDestruct)
            end
        end,

        [14] = function()
            if mobHPP < 20 then
                table.insert(tpList, xi.mobSkill.SELF_DESTRUCT_CLUSTER_1_DEATH)
            end
        end,
    }

    return tpList[math.random(1, #tpList)]
end

g_mixins.families.bomb_cluster = function(mob)
end

return g_mixins.families.bomb_cluster
