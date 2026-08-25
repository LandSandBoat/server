## How to make a dump file with Visual Studio 2019

(Make sure you're running your servers and you identified a crash for which you've been asked to provide a dump file.)

Execute Visual Studio 2019 > Debug > Attach to Process... > select `xi_map.exe` in the list > Attach.

Once the crash is reproduced while being monitored by Visual Studio 2019:

Debug > Save Dump As...

The same steps can be made through the Task Manager:

Right click on the taskbar > Task Manager > Processes > right click on `xi_map.exe` > Create Dump File.

**If you're asked for a dump file, you must also provide the `.exe` and `.pdb` files that were being used when you made your dump. The dump is useless without them**

---

## Auto-restarting while using GDB

Create a file in your server root directory called `multirun.gdb` with the following contents:
```gdb
while 1
  set confirm off
  set logging off 
  file xi_map
  run
  set logging on
  list
  bt
  x/5i $pc-6
end
```

Launch the game with `gdb -x multirun.gdb`.

If gdb catches a fatal crash, it will dump the source location (list), the stack trace (bt), and the last few assembly instructions (x/5i $pc-6) into `gdb.txt`. If you can't diagnose what the issue is from that output, staff will be able to help. The information is appended onto gdb.txt, so it can catch multiple crashes if needed.

This is preferable to a full core dump because it's quick and easy to catch multiple crashes and give a single file to developers.

The loop is pretty tight, you'll have to spam CTRL+C a few times to get back to the gdb interface. You can then quit with `quit`.

**Example output (gdb.txt):**
```cpp
12074    inline int32 CLuaBaseEntity::spawnTrust(lua_State *L)
12075    {
12076        XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
12077        XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC); // only PCs can spawn trusts
12078    
12079        ((CCharEntity*)m_PBaseEntity)->PPet->PMaster = nullptr;
12080    
12081        if (!lua_isnil(L, 1) && lua_isstring(L, 1))
12082        {
12083            uint16 trustId = (uint16)lua_tointeger(L, 1);
#0  0x00000000080cfff2 in CLuaBaseEntity::spawnTrust (this=0x7ffffffed3b8, L=0x7ffe0378) at src/map/lua/lua_baseentity.cpp:12079
#1  0x00007fffff738fb7 in ?? () from /lib/x86_64-linux-gnu/libluajit-5.1.so.2
#2  0x00007fffff7874a4 in lua_pcall () from /lib/x86_64-linux-gnu/libluajit-5.1.so.2
#3  0x0000000008075547 in CCommandHandler::call (this=0x826e7c8 <CmdHandler>, PChar=PChar@entry=0x393785b0, commandline=0x3914a023 "crash") at src/map/commandhandler.cpp:225
#4  0x00000000081015b7 in SmallPacket0x0B5 (session=<optimized out>, PChar=0x393785b0, data=...) at src/map/packets/basic.h:144
#5  0x00000000080dee1c in parse (buff=0x39149fe0 "\a", buffsize=0x7ffffffeded0, from=<optimized out>, map_session_data=0x39374e10) at src/map/../common/socket.h:295
#6  0x00000000080dfec9 in do_sockets (rfd=<optimized out>, next=...) at src/map/map.cpp:381
#7  0x000000000802d133 in main (argc=1, argv=0x7ffffffee378) at src/common/kernel.cpp:268
   0x80cffec <CLuaBaseEntity::spawnTrust(lua_State*)+44>:    mov    0x248(%rax),%eax
=> 0x80cfff2 <CLuaBaseEntity::spawnTrust(lua_State*)+50>:    movq   $0x0,0x250(%rax)
   0x80cfffd <CLuaBaseEntity::spawnTrust(lua_State*)+61>:    callq  0x801a230 <lua_type@plt>
   0x80d0002 <CLuaBaseEntity::spawnTrust(lua_State*)+66>:    test   %eax,%eax
   0x80d0004 <CLuaBaseEntity::spawnTrust(lua_State*)+68>:    je     0x80d0017 <CLuaBaseEntity::spawnTrust(lua_State*)+87>
```

---
