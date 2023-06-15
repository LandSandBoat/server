-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-----------------------------------
mixins = { require("scripts/mixins/families/antlion_ambush") }
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_REST, 1)

    -- Used with HPP to keep track of the number of Sandpits
    mob:setLocalVar("Sandpits", 0)
    mob:setRoamFlags(xi.roamFlag.SCRIPTED)
end

-- Reset restHP when re-engaging after a sandpit
entity.onMobEngaged = function(mob, target)
    local engaged = mob:getLocalVar("engaged")

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)

    if engaged == 0 then
        for _, v in pairs(mob:getBattlefield():getPlayers()) do
            v:messageSpecial(ID.text.GIANT_ANTLION)
        end

        mob:setLocalVar("engaged", 1)
    else
        for _, v in pairs(mob:getBattlefield():getPlayers()) do
            v:messageSpecial(ID.text.ANTLION_ESCAPED)
        end
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
            local posIndex = tuchulcha:getLocalVar("sand_pit" .. tuchulcha:getLocalVar('Sandpits'))
            local coords = ID.sheepInAntlionsClothing[tuchulcha:getBattlefield():getArea()].ant_positions[posIndex]
            tuchulcha:setSpawn(coords[1], coords[2], coords[3], 0)

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
    -- Despawn the hunters
    if optParams.isKiller then
        local bfID = mob:getBattlefield():getArea()
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SWIFT_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SHREWD_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].ARMORED_HUNTER_ID)

        -- Armoury Crate drops at Tuchulchua's feet
        GetNPCByID(mob:getID() + 4):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
        for _, v in pairs(mob:getBattlefield():getPlayers()) do
            v:messageSpecial(ID.text.TUCHCULA_CRATE)
        end
    end
end

return entity
