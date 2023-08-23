-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Lioumere
-----------------------------------
mixins = { require("scripts/mixins/families/antlion_ambush") }
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobWeaponSkill = function(player, mob, skill)
    --Sets entire party enmity CE/VE to 0.
    local alliance  = player:getAlliance() -- Gets member pointers for alliance
    for _, member in pairs(alliance) do
        local playerpet = member:getPet()
        mob:resetEnmity(member) -- Resets player enmity on the mob
        if playerpet then
            mob:resetEnmity(playerpet)
        end
    end
    mob:pathTo(478.8, 20, 41.7) -- Start walking home
end

entity.onMobFight = function(mob, player, target)
    if mob:atPoint(478.8, 20, 41.7) then
        mob:setHP(mob:getMaxHP())
    end

    local playerCE = mob:getCE(player)
    local playerVE = mob:getVE(player)
    if
        playerCE >= 180 or
        playerVE >= 600
    then
        mob:clearPath()
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
