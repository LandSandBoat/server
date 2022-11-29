-----------------------------------
-- Area: Southern Sandoria
--  NPC: Estiliphire
-- Type: Event Sideshow NPC
-- !pos -41.550 1.999 -2.845 230
-- TODO: Additional event logic, advanced mode.
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- if xi.settings.main.ENABLE_CHRISTMAS == 1 then
    --     if player:getEquipID(xi.slot.HANDS) == 10382 or player:getEquipID(xi.slot.HANDS) == 10383 then
    --         player:startEvent(986, 1, 2)
    --     else
    --         player:startEvent(986)
    --     end
    -- else
    --     player:startEvent(897)
    -- end
end

entity.onEventUpdate = function(player, csid, option)
    -- print("start of function " .. option)
    -- if csid == 986 then -- Starlight Festival
    --     if option == 65536 then -- Simple game
    --         player:updateEvent(986, player:getGil(), option)
    --     elseif option == 2162688 then -- Advanced game
    --         player:updateEvent(986, player:getGil(), option)
    --     elseif option == 2228224 then
    --         player:updateEvent(986, 1, 20, 15, option)
    --     end
    -- end
end

--if csid == 986 and option == 65536 then
    --     print(option)
    --     player:updateEvent(986, player:getGil(), option)
    -- elseif csid == 986 and option == 131072 then
    --     print(option)
    --     player:delGil(10)
    --     player:updateEvent(986, 1, 0, 3)
    -- elseif csid == 986 and option == 196610 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 22)
    -- elseif csid == 986 and option == 196608 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 50)
    -- elseif csid == 986 and option == 196609 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 53)
    -- elseif csid == 986 and option == 196611 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 35)
    -- elseif csid == 986 and option == 196612 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 36)
    -- elseif csid == 986 and option == 196613 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 37)
    -- elseif csid == 986 and option == 196614 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 65)
    -- elseif csid == 986 and option == 196615 then
    --     print(option)
    --     player:updateEvent(986, 1, 0, 20, 22, 53)
    -- end

-- csid, game type (simple or advanced), difference modifier, menu modifier, answer option

--22 successful guess, 50/52 normal prize, 51 advanced (dream mitts +1) 53 advanced prize orchestrion full text
-- 196608-196615 0-7 guesses

-- Menu Options --
-- 196608: The Galka's/male Hume's/female Hume's/male Elvaan's/female Elvaan's/Mithra's head gear.
-- 196609: The female Tarutaru's expression.
-- 196610: The direction the male Hume/female hume/male Elvaan/female Elvaan/Gaklka/Mithra faced./The female Hume's/Mithra's weaopn.
-- 196611: The kind of treasure chest.
-- 196612: Rabbit in the treasure chest.
-- 196613: Different chest for the chocobo.
-- 196614: The order in which the doors closed.
-- 196615: Give up.

-- 0 nothing
-- 1 pumpkin head
-- 2 taru expression
-- 3 pumpkin head, taru expression
-- 4 treat staff
-- 5 treat staff, pumpkin head
-- 6 treat staff, taru expression
-- 7 treat staff, pumpkin head, taru expression
-- 8 hume looking left
-- 9 hume looking left, pumpkin head
-- 10 hume looking left, taru expression
-- 11 hume looking left, pumpkin head, taru expression
-- 12 hume looking left, treat staff
-- 13 hume looking left, pumpkin head, treat staff
-- 14 hume looking left, treat staff, taru expression
-- 15 hume looking left, pumpkin head, treat staff, taru expression (*)
-- 16 coffers
-- 17 coffers, pumpkin head
-- 18 coffers, taru expression
-- 19 coffers, pumpkin head, taru expression
-- 20 coffers, treat staff
-- 21 coffers, pumpkin head, treat staff
-- 22 coffers, treat staff, taru expression
-- 23 coffers, treat staff, jack-o-lantern and taru expression (*)
-- 24 coffers, hume looking left
-- 25 coffers, hume looking left, pumpkin head
-- 26 coffers, hume looking left, taru expression
-- 27 coffers, hume looking left, pumpkin head, taru expression (*)
-- 28 coffers, hume looking left, treat staff
-- 29 coffers, hume looking left, pumpkin head, treat staff (*)
-- 30 coffers, hume looking left, treet staff, taru expression (*)
-- 31 coffers, hume looking left, treat staff, pumpkin head, taru expression (*)
-- 32 bunny
-- 33 bunny, pumpkin head,
-- 34 bunny, taru expression
-- 35 bunny, pumpkin head, taru expression
-- 36 bunny, treat staff
-- 37 bunny, pumpkin head, treat staff
-- 38 bunny, treat staff, taru expression
-- 39 bunny, pumpkin head, treat staff, taru expression (*)
-- 40 bunny, hume looking left
-- 41 bunny, pumpkin head, hume looking left,
-- 42 bunny, hume looking left, taru expression
-- 43 bunny, pumpkin head, hume looking left, taru expression (*)
-- 44 bunny, hume looking left, treat staff
-- 45 bunny, treat staff, pumpkin head, hume looking left (*)
-- 46 bunny, hume looking left, treat staff, taru expression (*)
-- 47 bunny, pumpkin head, treat staff, hume looking left, taru expression (*)
-- 48 bunny, coffers
-- 49 bunny, coffers, pumpkin head
-- 50 bunny, coffers, taru expression
-- 51 bunny, coffers, pumpkin head, taru expression (*)
-- 52 bunny, coffers, treat staff
-- 53 bunny, coffers, pumpkin head, treat staff (*)
-- 54 bunny, treat staff, coffers, taru expression (*)
-- 55 bunny, coffers, pumpkin head, treat staff, taru expression (*)
-- 56 bunny, coffers, hume looking left
-- 57 bunny, coffers, pumpkin head, hume looking left (*)
-- 58 bunny, coffers, hume looking left, bunny, taru expression (*)
-- 59 bunny, coffers, pumpkin head, hume looking left, taru expression (*)
-- 60 bunny, coffers, hume looking left, treat staff(*)
-- 61 bunny, coffers, hume looking left, pumpkin head, treat staff (*)
-- 62 bunny, coffers, treat staff, hume looking left, taru expression (*)
-- 63 bunny, coffers, hume looking left, pumpkin head, treat staff, taru expression (*)
-- 64 chocobo swap
-- 65 chocobo swap, pumpkin head
-- 66 chocobo swap, taru expresison, orchestrion text
-- 67 chocobo swap, pumpkin head, taru expression
-- 68 chocobo swap, treat staff
-- 69 chocobo swap, pumpkin head, treat staff
-- 70 chocobo swap, treat staff, taru expression
-- 128 doors swap
-- 256 elvaan male weapon
-- 512 elvaan female leggings
-- 1024 taru location
-- 2048 exclaimation points
-- 4096 wind instrument
-- 8192 chests open
-- 16384 # of baby chocobos
-- 32768 length of scene

entity.onEventFinish = function(player, csid, option)
end

return entity
