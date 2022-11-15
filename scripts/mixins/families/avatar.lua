require("scripts/globals/mixins")

-- If you subtract 790 from the modelId, you're left with a key into to this table :)
local abilityIds =
{
    919, -- [modelId: 791] Carbuncle
    839, -- [modelId: 792] Fenrir
    913, -- [modelId: 793] Ifrit
    914, -- [modelId: 794] Titan
    915, -- [modelId: 795] Leviathan
    916, -- [modelId: 796] Garuda
    917, -- [modelId: 797] Shiva
    918, -- [modelId: 798] Ramuh
}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.avatar = function(avatarMob)
    avatarMob:addListener("SPAWN", "AVATAR_SPAWN", function(mob)
        mob:setModelId(math.random(791, 798))
        mob:hideName(false)
        mob:setUntargetable(true)
        mob:setUnkillable(true)
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)

        -- If something goes wrong, the avatar will clean itself up in 5s
        mob:timer(5000, function(mobArg)
            if mobArg:isAlive() then
                mobArg:setUnkillable(false)
                mobArg:setHP(0)
            end
        end)
    end)

    avatarMob:addListener("ENGAGE", "AVATAR_ENGAGE", function(mob, target)
        local modelId = mob:getModelId()
        local abilityId = abilityIds[modelId - 790]
        if abilityId ~= nil then
            mob:useMobAbility(abilityId)
        end
    end)

    avatarMob:addListener("WEAPONSKILL_STATE_EXIT", "AVATAR_MOBSKILL_FINISHED", function(mob)
        mob:setUnkillable(false)
        mob:setHP(0)
    end)
end

return g_mixins.families.avatar
