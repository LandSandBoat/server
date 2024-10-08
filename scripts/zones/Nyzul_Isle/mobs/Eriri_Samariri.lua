-----------------------------------
--  MOB: Eiri Samasriri
-- Area: Nyzul Isle
-- Info: Enemy Leader, Spams Frog Song
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob, target)
    if math.random(1, 4) > 1 then
        return 1957
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
        local instance = mob:getInstance()
        if not instance then
            return
        end

        local chars = instance:getChars()

        for _, entities in ipairs(chars) do
            if player:hasStatusEffect(xi.effect.COSTUME) then
                player:delStatusEffect(xi.effect.COSTUME)
            end
        end
    end
end

return entity
