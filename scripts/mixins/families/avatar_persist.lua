require("scripts/globals/mixins")

-- If you subtract 790 from the modelId, you're left with a key into to this table :)
local skillLists =
{
    [791] = 34, -- [modelId: 791] Carbuncle
    [792] = 36, -- [modelId: 792] Fenrir
    [793] = 38, -- [modelId: 793] Ifrit
    [794] = 45, -- [modelId: 794] Titan
    [795] = 40, -- [modelId: 795] Leviathan
    [796] = 37, -- [modelId: 796] Garuda
    [797] = 44, -- [modelId: 797] Shiva
    [798] = 43, -- [modelId: 798] Ramuh
}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.avatar_persist = function(avatarMob)
    avatarMob:addListener("ENGAGE", "AVATAR_ENGAGE", function(mob, target)
        local skillList = skillLists[mob:getModelId()]
        if skillList ~= nil then
            mob:setMobMod(xi.mobMod.SKILL_LIST, skillList)
        end
    end)
end

return g_mixins.families.avatar_persist
