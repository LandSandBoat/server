-----------------------------------
-- A Shantotto Ascension Helpers
-----------------------------------
xi = xi or {}
xi.asa = xi.asa or {}
xi.asa.helpers = xi.asa.helpers or {}

local hp = { 80, 60, 40, 20, 1 }

local abilities =
{
    [7041] = 893, -- Ramuh
    [7042] = 857, -- Titan
    [7043] = 848, -- Ifrit
    [7044] = 866, -- Leviathan
    [7045] = 875, -- Garuda
    [7046] = 884, -- Shiva
}

xi.asa.helpers.astralFlow = function(mob)
    local astralFlows = mob:getLocalVar('astralflows')
    for k, v in pairs(hp) do
        if astralFlows == k and mob:getHPP() <= v and mob:canUseAbilities() then
            mob:setLocalVar('astralflows', astralFlows + 1)
            mob:useMobAbility(abilities[mob:getPool()])
        end
    end

    if astralFlows >= 5 and mob:canUseAbilities() then
        mob:setUnkillable(false)
    end
end
