-----------------------------------
-- Dynamis Beastmen NMs Era Module
-----------------------------------
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("scripts/globals/mixins")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnBeastmenNM = function(mob)
    mixins =
    {
        require("scripts/mixins/job_special"),
        require("scripts/mixins/remove_doom")
    }
    xi.dynamis.setNMStats(mob)
end

xi.dynamis.onSpawnBeastmen = function(mob)
    mixins = {require("scripts/mixins/job_special"),}
    xi.dynamis.setMobStats(mob)
end

xi.dynamis.onSpawnPet = function(mob)
    xi.dynamis.setPetStats(mob)
end

xi.dynamis.onSpawnSMNAF = function(mob)
    mixins = {require("scripts/mixins/families/avatar"),}
    xi.dynamis.setPetStats(mob)
    mob:setModelId(math.random(791, 798))
    mob:hideName(false)
    mob:untargetable(true)
    mob:setUnkillable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
end

xi.dynamis.onFightSMN = function(mob, target)
    if GetMobByID(mob:getLocalVar("PetMaster_ID")):hasStatusEffect(xi.effect.ASTRAL_FLOW) then
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
    end
end

xi.dynamis.onFightApocDRG = function(mob, target)
    local apoc = GetMobByID(mob:getZone():getLocalVar("Apocalyptic_Beast"))
    if os.time() >= apoc:getLocalVar("next2hrTime") then
        DespawnMob(mob:getID())
    end
end
