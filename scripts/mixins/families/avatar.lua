require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.avatar = function(avatarMob)
    avatarMob:addListener("SPAWN", "AVATAR_SPAWN", function(mob)
        mob:setModelId(math.random(791, 798))
        mob:hideName(false)
        mob:untargetable(true)
        mob:setUnkillable(true)
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
    end)

    avatarMob:addListener("ENGAGE", "AVATAR_ENGAGE", function(mob, target)
        local abilityID = nil
        local modelID = mob:getModelId()

        switch (modelID) : caseof
        {
             [791] = function (x) abilityID = 919 end, -- Carbuncle
             [792] = function (x) abilityID = 839 end, -- Fenrir
             [793] = function (x) abilityID = 913 end, -- Ifrit
             [794] = function (x) abilityID = 914 end, -- Titan
             [795] = function (x) abilityID = 915 end, -- Leviathan
             [796] = function (x) abilityID = 916 end, -- Garuda
             [797] = function (x) abilityID = 917 end, -- Shiva
             [798] = function (x) abilityID = 918 end, -- Ramuh
        }

        if (abilityID ~= nil) then
            mob:useMobAbility(abilityID)
        end
    end)

    avatarMob:addListener("WEAPONSKILL_STATE_EXIT", "AVATAR_MOBSKILL_FINISHED", function(mob)
        mob:setUnkillable(false)
        mob:setHP(0)
    end)
end

return g_mixins.families.avatar
