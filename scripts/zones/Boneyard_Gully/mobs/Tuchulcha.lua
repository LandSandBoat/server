-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-----------------------------------
mixins = { require("scripts/mixins/families/antlion_ambush") }
local ID = require("scripts/zones/Boneyard_Gully/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)

    -- Used with HPP to keep track of the number of Sandpits
    mob:setLocalVar("Sandpits", 0)
end

-- Reset restHP when re-engaging after a sandpit
entity.onMobEngaged = function(mob, target)
    if mob:getMobMod(xi.mobMod.NO_REST) == 1 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setMobMod(xi.mobMod.NO_REST, 0)
    end
end

entity.onMobFight = function(mob, target)
    -- Every 25% of its HP Tuchulcha will bury itself under the sand
    -- accompanied by use of the ability Sandpit
    if
        (mob:getHPP() < 75 and mob:getLocalVar('Sandpits') == 0) or
        (mob:getHPP() < 50 and mob:getLocalVar('Sandpits') == 1) or
        (mob:getHPP() < 25 and mob:getLocalVar('Sandpits') == 2)
    then
        mob:setLocalVar('Sandpits', mob:getLocalVar('Sandpits') + 1)
        mob:useMobAbility(276)
        mob:timer(4000, function(tuchulcha)
            tuchulcha:disengage()
            tuchulcha:setMobMod(xi.mobMod.NO_MOVE, 1)
            tuchulcha:setMobMod(xi.mobMod.NO_REST, 1)
            local posIndex = tuchulcha:getLocalVar("sand_pit" .. tuchulcha:getLocalVar('Sandpits'))
            local coords   = ID.sheepInAntlionsClothing[tuchulcha:getBattlefield():getArea()].ant_positions[posIndex]

            tuchulcha:setPos(coords)
            local players = tuchulcha:getBattlefield():getPlayers()
            for _, char in pairs(players) do
                char:messageSpecial(ID.text.TUCHULCHA_SANDPIT)
                char:disengage()
                if char:hasPet() then
                    char:petRetreat()
                end
            end
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Used to grab the mob IDs
    -- Despawn the hunters
    if optParams.isKiller then
        local bfID = mob:getBattlefield():getArea()
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SWIFT_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SHREWD_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].ARMORED_HUNTER_ID)
    end
end

return entity
