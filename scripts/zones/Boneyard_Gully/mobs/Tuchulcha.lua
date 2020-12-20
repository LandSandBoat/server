-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
local ID = require("scripts/zones/Boneyard_Gully/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(tpz.mobMod.SUPERLINK, 0)

    -- Used with HPP to keep track of the number of Sandpits
    mob:setLocalVar("Sandpits", 0)
end

-- Reset restHP when re-engaging after a sandpit
function onMobEngaged(mob, target)
    if mob:getMobMod(tpz.mobMod.NO_REST) == 1 then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setMobMod(tpz.mobMod.NO_REST, 0)
    end
end

function onMobFight(mob, target)
    -- Every 25% of its HP Tuchulcha will bury itself under the sand
    -- accompanied by use of the ability Sandpit
    if (mob:getHPP() < 75 and mob:getLocalVar('Sandpits') == 0)
    or (mob:getHPP() < 50 and mob:getLocalVar('Sandpits') == 1)
    or (mob:getHPP() < 25 and mob:getLocalVar('Sandpits') == 2) then
        mob:setLocalVar('Sandpits', mob:getLocalVar('Sandpits') + 1)
        mob:useMobAbility(276)
        mob:timer(4000, function(tuchulcha)
            tuchulcha:disengage()
            tuchulcha:setMobMod(tpz.mobMod.NO_MOVE, 1)
            tuchulcha:setMobMod(tpz.mobMod.NO_REST, 1)
            local pos_index = tuchulcha:getLocalVar("sand_pit" .. tuchulcha:getLocalVar('Sandpits'))
            local coords = ID.sheepInAntlionsClothing[tuchulcha:getBattlefield():getArea()].ant_positions[pos_index]
            tuchulcha:setPos(coords)
            for _, char in pairs(tuchulcha:getBattlefield():getPlayers()) do
                char:messageSpecial(ID.text.TUCHULCHA_SANDPIT)
                char:disengage()
                if char:hasPet() then
                    char:petRetreat()
                end
            end
        end)
    end
end

function onMobDeath(mob, player, isKiller)
    -- Used to grab the mob IDs
    -- Despawn the hunters
    if isKiller then
        local bfID = mob:getBattlefield():getArea()
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SWIFT_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].SHREWD_HUNTER_ID)
        DespawnMob(ID.sheepInAntlionsClothing[bfID].ARMORED_HUNTER_ID)
    end
end
