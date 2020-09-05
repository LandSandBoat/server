// Copyright (c) 2010-2015 Darkstar Dev Teams

#include "../common/cbasetypes.h"
#include "../common/mmo.h"
#include "../common/timer.h"
#include "../common/showmsg.h"
#include "../common/taskmgr.h"
#include "../common/kernel.h"
#include "../common/utils.h"

#include "socket.h"

#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <sys/types.h>

#ifdef WIN32
	#include <winsock2.h>
	#include <io.h>
#else
	#include <errno.h>
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <netinet/tcp.h>
	#include <net/if.h>
	#include <unistd.h>
	#include <sys/time.h>
	#include <sys/ioctl.h>
	#include <netdb.h>
	#include <arpa/inet.h>

	#ifndef SIOCGIFCONF
	#include <sys/sockio.h> // SIOCGIFCONF on Solaris, maybe others? [Shinomori]
	#endif

	#ifdef HAVE_SETRLIMIT
	#include <sys/resource.h>
	#endif
#endif

/////////////////////////////////////////////////////////////////////
#if defined(WIN32)
/////////////////////////////////////////////////////////////////////
// windows portability layer

typedef int socklen_t;

#define sErrno WSAGetLastError()
#define S_ENOTSOCK WSAENOTSOCK
#define S_EWOULDBLOCK WSAEWOULDBLOCK
#define S_EINTR WSAEINTR
#define S_ECONNABORTED WSAECONNABORTED


SOCKET sock_arr[FD_SETSIZE];
int sock_arr_len = 0;


/// Returns the first fd associated with the socket.
/// Returns -1 if the socket is not found.
///
/// @param s Socket
/// @return Fd or -1
int sock2fd(SOCKET s)
{
	int fd;

	// search for the socket
	for( fd = 1; fd < sock_arr_len; ++fd )
		if( sock_arr[fd] == s )
			break;// found the socket
	if( fd == sock_arr_len )
		return -1;// not found
	return fd;
}


/// Inserts the socket into the global array of sockets.
/// Returns a new fd associated with the socket.
/// If there are too many sockets it closes the socket, sets an error and
//  returns -1 instead.
/// Since fd 0 is reserved, it returns values in the range [1,FD_SETSIZE[.
///
/// @param s Socket
/// @return New fd or -1
int sock2newfd(SOCKET s)
{
	int fd;

	// find an empty position
	for( fd = 1; fd < sock_arr_len; ++fd )
		if( sock_arr[fd] == INVALID_SOCKET )
			break;// empty position
    if (fd == (sizeof(sock_arr) / sizeof(sock_arr[0])))
	{
        // too many sockets
		closesocket(s);
		WSASetLastError(WSAEMFILE);
		return -1;
	}
	sock_arr[fd] = s;
	if( sock_arr_len <= fd )
		sock_arr_len = fd+1;
	return fd;
}

int sAccept(int fd, struct sockaddr* addr, int* addrlen)
{
	SOCKET s;

	// accept connection
	s = accept(fd2sock(fd), addr, addrlen);
	if( s == INVALID_SOCKET )
		return -1;// error
	return sock2newfd(s);
}

int sClose(int fd)
{
	int ret = closesocket(fd2sock(fd));
	fd2sock(fd) = INVALID_SOCKET;
	return ret;
}

int sSocket(int af, int type, int protocol)
{
	SOCKET s;

	// create socket
	s = socket(af,type,protocol);
	if( s == INVALID_SOCKET )
		return -1;// error
	return sock2newfd(s);
}
///////////////////////////////////////////////////////////////////////
#else // *nix sys
///////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////
#endif
/////////////////////////////////////////////////////////////////////

/*
*
*			COMMON LEVEL
*
*/

socket_type SOCKET_TYPE;

fd_set readfds;
int32 fd_max;
time_t last_tick;
time_t tick_time;
time_t stall_time = 60;

int32 makeConnection(uint32 ip, uint16 port, int32 type)
{
	struct sockaddr_in remote_address;
	int32 fd;
	int32 result;

	fd = sSocket(AF_INET, type, 0);

	if (fd == -1) {
		ShowError("make_connection: socket creation failed (code %d)!\n", sErrno);
		return -1;
	}
	if( fd == 0 )
	{// reserved
		ShowError("make_connection: Socket #0 is reserved - Please report this!!!\n");
		sClose(fd);
		return -1;
	}
	if( fd >= FD_SETSIZE )
	{// socket number too big
		ShowError("make_connection: New socket #%d is greater than can we handle! Increase the value of FD_SETSIZE (currently %d) for your OS to fix this!\n", fd, FD_SETSIZE);
		sClose(fd);
		return -1;
	}

	//setsocketopts(fd);
	struct linger opt;
	opt.l_onoff = 0; // SO_DONTLINGER
	opt.l_linger = 0; // Do not care
	if( sSetsockopt(fd, SOL_SOCKET, SO_LINGER, (char*)&opt, sizeof(opt)) )
	{
		ShowWarning("setsocketopts: Unable to set SO_LINGER mode for connection #%d!\n", fd);
	}

	remote_address.sin_family      = AF_INET;
	remote_address.sin_addr.s_addr = htonl(ip);
	remote_address.sin_port        = htons(port);

	ShowStatus("Connecting to %d.%d.%d.%d:%i\n", CONVIP(ip), port);

	result = sConnect(fd, (struct sockaddr *)(&remote_address), sizeof(struct sockaddr_in));
	if( result == SOCKET_ERROR ) {
		ShowError("make_connection: connect failed (socket #%d, code %d)!\n", fd, sErrno);
		do_close(fd);
		return -1;
	}
	//Now the socket can be made non-blocking. [Skotlex]
	//set_nonblocking(fd, 1);
	u_long yes = 1;
	if( sIoctl(fd, FIONBIO, &yes) != 0 )
		ShowError("set_nonblocking: Failed to set socket #%d to non-blocking mode (code %d) - Please report this!!!\n", fd, sErrno);

	if (fd_max <= fd) fd_max = fd + 1;
	sFD_SET(fd,&readfds);

	return fd;
}

void do_close(int32 fd)
{
	sFD_CLR(fd, &readfds);// this needs to be done before closing the socket
	sShutdown(fd, SHUT_RDWR); // Disallow further reads/writes
	sClose(fd); // We don't really care if these closing functions return an error, we are just shutting down and not reusing this socket.
}

bool _vsocket_init(void)
{
#ifdef WIN32
	{// Start up windows networking
		WSADATA wsaData;
		WORD wVersionRequested = MAKEWORD(2, 0);
		if( WSAStartup(wVersionRequested, &wsaData) != 0 )
		{
			ShowError("socket_init: WinSock not available!\n");
			return false;
		}
		if( LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 0 )
		{
			ShowError("socket_init: WinSock version mismatch (2.0 or compatible required)!\n");
			return false;
		}
	}
#elif defined(HAVE_SETRLIMIT) && !defined(CYGWIN)
	// NOTE: getrlimit and setrlimit have bogus behaviour in cygwin.
	//       "Number of fds is virtually unlimited in cygwin" (sys/param.h)
	{// set socket limit to FD_SETSIZE
		struct rlimit rlp;
		if( 0 == getrlimit(RLIMIT_NOFILE, &rlp) )
		{
			rlp.rlim_cur = FD_SETSIZE;
			if( 0 != setrlimit(RLIMIT_NOFILE, &rlp) )
			{// failed, try setting the maximum too (permission to change system limits is required)
				rlp.rlim_max = FD_SETSIZE;
				if( 0 != setrlimit(RLIMIT_NOFILE, &rlp) )
				{// failed
					// set to maximum allowed
					getrlimit(RLIMIT_NOFILE, &rlp);
					rlp.rlim_cur = rlp.rlim_max;
					setrlimit(RLIMIT_NOFILE, &rlp);
					// report limit
					getrlimit(RLIMIT_NOFILE, &rlp);
					ShowWarning("socket_init: failed to set socket limit to %d (current limit %d).\n", FD_SETSIZE, (int)rlp.rlim_cur);
				}
			}
		}
	}
#endif

	sFD_ZERO(&readfds);

	// initialise last send-receive tick
	last_tick = time(NULL);
	return true;
}

bool _vsocket_final(void){
	return true;
}

// hostname/ip conversion functions
std::string ip2str(uint32 ip)
{
    uint32 reversed_ip = htonl(ip);
    char address[INET_ADDRSTRLEN];
    inet_ntop(AF_INET, &reversed_ip, address, INET_ADDRSTRLEN);
    return std::string(address);
}

uint32 str2ip(const char* ip_str)
{
    uint32 ip;
    inet_pton(AF_INET, ip_str, &ip);

    return ntohl(ip);
}

// Reorders bytes from network to little endian (Windows).
// Neccessary for sending port numbers to the RO client until Gravity notices that they forgot ntohs() calls.
uint16 ntows(uint16 netshort)
{
	return ((netshort & 0xFF) << 8) | ((netshort & 0xFF00) >> 8);
}
/*****************************************************************************/
/*
*
*			TCP LEVEL
*
*/


#ifndef MINICORE
	int ip_rules = 1;
	static int connect_check(uint32 ip);
#endif

//////////////////////////////
#ifndef MINICORE
//////////////////////////////
// IP rules and DDoS protection

typedef struct _connect_history {
	struct _connect_history* next;
	uint32 ip;
	time_point tick;
	int count;
	unsigned ddos : 1;
} ConnectHistory;

typedef struct _access_control {
	uint32 ip;
	uint32 mask;
} AccessControl;

enum _aco {
	ACO_DENY_ALLOW,
	ACO_ALLOW_DENY,
	ACO_MUTUAL_FAILURE
};

static std::vector<AccessControl> access_allow;
static std::vector<AccessControl> access_deny;
static int access_order = ACO_DENY_ALLOW;
static int access_debug    = 0;
//--
static int ddos_count      = 10;
static duration ddos_interval = 3s;
static duration ddos_autoreset = 10min;

/// Connection history, an array of linked lists.
/// The array's index for any ip is ip&0xFFFF
static ConnectHistory* connect_history[0x10000];


static int connect_check_(uint32 ip);

/// Verifies if the IP can connect. (with debug info)
/// @see connect_check_()
static int connect_check(uint32 ip)
{
	int result = connect_check_(ip);
	if( access_debug ) {
		ShowInfo("connect_check: Connection from %d.%d.%d.%d %s\n", CONVIP(ip),result ? "allowed." : "denied!");
	}
	return result;
}

/// Verifies if the IP can connect.
///  0      : Connection Rejected
///  1 or 2 : Connection Accepted
static int connect_check_(uint32 ip)
{
	ConnectHistory* hist = connect_history[ip&0xFFFF];
	size_t i;
	int is_allowip = 0;
	int is_denyip = 0;
	int connect_ok = 0;

	// Search the allow list
	for( i=0; i < access_allow.size(); ++i ){
		if( (ip & access_allow[i].mask) == (access_allow[i].ip & access_allow[i].mask) ){
			if( access_debug ){
				ShowInfo("connect_check: Found match from allow list:%d.%d.%d.%d IP:%d.%d.%d.%d Mask:%d.%d.%d.%d\n",
					CONVIP(ip),
					CONVIP(access_allow[i].ip),
					CONVIP(access_allow[i].mask));
			}
			is_allowip = 1;
			break;
		}
	}
	// Search the deny list
	for( i=0; i < access_deny.size(); ++i ){
		if( (ip & access_deny[i].mask) == (access_deny[i].ip & access_deny[i].mask) ){
			if( access_debug ){
				ShowInfo("connect_check: Found match from deny list:%d.%d.%d.%d IP:%d.%d.%d.%d Mask:%d.%d.%d.%d\n",
					CONVIP(ip),
					CONVIP(access_deny[i].ip),
					CONVIP(access_deny[i].mask));
			}
			is_denyip = 1;
			break;
		}
	}
	// Decide connection status
	//  0 : Reject
	//  1 : Accept
	//  2 : Unconditional Accept (accepts even if flagged as DDoS)
	switch(access_order) {
	case ACO_DENY_ALLOW:
	default:
		if( is_denyip )
			connect_ok = 0; // Reject
		else if( is_allowip )
			connect_ok = 2; // Unconditional Accept
		else
			connect_ok = 1; // Accept
		break;
	case ACO_ALLOW_DENY:
		if( is_allowip )
			connect_ok = 2; // Unconditional Accept
		else if( is_denyip )
			connect_ok = 0; // Reject
		else
			connect_ok = 1; // Accept
		break;
	case ACO_MUTUAL_FAILURE:
		if( is_allowip && !is_denyip )
			connect_ok = 2; // Unconditional Accept
		else
			connect_ok = 0; // Reject
		break;
	}

	// Inspect connection history
	while( hist ) {
		if( ip == hist->ip )
		{// IP found
			if( hist->ddos )
			{// flagged as DDoS
				return (connect_ok == 2 ? 1 : 0);
			} else if( (server_clock::now() - hist->tick) < ddos_interval )
			{// connection within ddos_interval
                hist->tick = server_clock::now();
				if( hist->count++ >= ddos_count )
				{// DDoS attack detected
					hist->ddos = 1;
					ShowWarning("connect_check: DDoS Attack detected from %d.%d.%d.%d!\n", CONVIP(ip));
					return (connect_ok == 2 ? 1 : 0);
				}
				return connect_ok;
			} else
			{// not within ddos_interval, clear data
                hist->tick = server_clock::now();
				hist->count = 0;
				return connect_ok;
			}
		}
		hist = hist->next;
	}
	// IP not found, add to history
	hist = new ConnectHistory{};
	hist->ip   = ip;
    hist->tick = server_clock::now();
	hist->next = connect_history[ip&0xFFFF];
	connect_history[ip&0xFFFF] = hist;
	return connect_ok;
}

/// Timer function.
/// Deletes old connection history records.
static int connect_check_clear(time_point tick,CTaskMgr::CTask* PTask)
{
	int i;
	int clear = 0;
	int list  = 0;
	ConnectHistory root;
	ConnectHistory* prev_hist;
	ConnectHistory* hist;

	for( i=0; i < 0x10000 ; ++i ){
		prev_hist = &root;
		root.next = hist = connect_history[i];
		while( hist ){
			if( (!hist->ddos && (tick - hist->tick) > ddos_interval*3) ||
					(hist->ddos && (tick - hist->tick) > ddos_autoreset) )
			{// Remove connection history
				prev_hist->next = hist->next;
				delete hist;
				hist = prev_hist->next;
				clear++;
			} else {
				prev_hist = hist;
				hist = hist->next;
			}
			list++;
		}
		connect_history[i] = root.next;
	}
	if( access_debug ){
		ShowInfo("connect_check_clear: Cleared %d of %d from IP list.\n", clear, list);
	}
	return list;
}

/// Parses the ip address and mask and puts it into acc.
/// Returns 1 is successful, 0 otherwise.
int access_ipmask(const char* str, AccessControl* acc)
{
	uint32 ip;
	uint32 mask;
	unsigned int a[4];
	unsigned int m[4];
	int n;

	if( strcmp(str,"all") == 0 ) {
		ip   = 0;
		mask = 0;
	} else {
		if( ((n=sscanf(str,"%u.%u.%u.%u/%u.%u.%u.%u",a,a+1,a+2,a+3,m,m+1,m+2,m+3)) != 8 && // not an ip + standard mask
				(n=sscanf(str,"%u.%u.%u.%u/%u",a,a+1,a+2,a+3,m)) != 5 && // not an ip + bit mask
				(n=sscanf(str,"%u.%u.%u.%u",a,a+1,a+2,a+3)) != 4 ) || // not an ip
				a[0] > 255 || a[1] > 255 || a[2] > 255 || a[3] > 255 || // invalid ip
				(n == 8 && (m[0] > 255 || m[1] > 255 || m[2] > 255 || m[3] > 255)) || // invalid standard mask
				(n == 5 && m[0] > 32) ){ // invalid bit mask
			return 0;
		}
		ip = (uint32)(a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24));
		if( n == 8 )
		{// standard mask
			mask = (uint32)(a[0] | (a[1] << 8) | (a[2] << 16) | (a[3] << 24));
		} else if( n == 5 )
		{// bit mask
			mask = 0;
			while( m[0] ){
				mask = (mask >> 1) | 0x80000000;
				--m[0];
			}
		} else
		{// just this ip
			mask = 0xFFFFFFFF;
		}
	}

    ip = ntohl(ip);

	if( access_debug ){
		ShowInfo("access_ipmask: Loaded IP:%d.%d.%d.%d mask:%d.%d.%d.%d\n", CONVIP(ip), CONVIP(mask));
	}
	acc->ip   = ip;
	acc->mask = mask;
	return 1;
}
//////////////////////////////
#endif
//////////////////////////////
int recv_to_fifo(int fd)
{
	int len;

	if( !session_isActive(fd) )
		return -1;

    auto prev_length = session[fd]->rdata.size();
    session[fd]->rdata.resize(prev_length + 0x7FF);
	len = sRecv(fd, (char *) session[fd]->rdata.data() + prev_length, (int)(session[fd]->rdata.capacity() - prev_length), 0);

	if( len == SOCKET_ERROR )
	{//An exception has occured
		if( sErrno != S_EWOULDBLOCK ) {
			//ShowDebug("recv_to_fifo: code %d, closing connection #%d\n", sErrno, fd);
			set_eof(fd);
		}
		return 0;
	}

	if( len == 0 )
	{//Normal connection end.
		set_eof(fd);
		return 0;
	}

    session[fd]->rdata.resize(prev_length + len);
	session[fd]->rdata_tick = last_tick;
	return 0;
}

int send_from_fifo(int fd)
{
	int len;

	if( !session_isValid(fd) )
		return -1;

	if( session[fd]->wdata.empty() )
		return 0; // nothing to send

	len = sSend(fd, session[fd]->wdata.data(), (int)session[fd]->wdata.size(), 0);

	if( len == SOCKET_ERROR )
	{//An exception has occured
		if( sErrno != S_EWOULDBLOCK ) {
			//ShowDebug("send_from_fifo: error %d, ending connection #%d\n", sErrno, fd);
			session[fd]->wdata.clear(); //Clear the send queue as we can't send anymore. [Skotlex]
			set_eof(fd);
		}
		return 0;
	}

	if( len > 0 )
	{
		// some data could not be transferred?
		// shift unsent data to the beginning of the queue
        if((size_t)len < session[fd]->wdata.size())
            session[fd]->wdata.erase(0, len);
        else
            session[fd]->wdata.clear();
	}

	return 0;
}

/*======================================
 *	CORE : Default processing functions
 *--------------------------------------*/
int null_recv(int fd) { return 0; }
int null_send(int fd) { return 0; }
int null_parse(int fd) { return 0; }

ParseFunc default_func_parse = null_parse;

std::array<std::unique_ptr<socket_data>, FD_SETSIZE> session;

bool session_isValid(int fd)
{
	return ( fd > 0 && fd < FD_SETSIZE && session[fd] != NULL );
}
bool session_isActive(int fd)
{
	return ( session_isValid(fd) && !session[fd]->flag.eof );
}

int32 makeConnection_tcp(uint32 ip, uint16 port)
{
	int fd = makeConnection(ip,port,SOCK_STREAM);
	if( fd > 0 )
	{
		create_session(fd, recv_to_fifo, send_from_fifo, default_func_parse);
		session[fd]->client_addr = ip;
	}
	return fd;
}
/*======================================
 *	CORE : Connection functions
 *--------------------------------------*/
int connect_client(int listen_fd, sockaddr_in& client_address)
{
	int fd;
	//struct sockaddr_in client_address;
	socklen_t len;

	len = sizeof(client_address);

 	fd = sAccept(listen_fd, (struct sockaddr*)&client_address, &len);
	if ( fd == -1 ) {
		ShowError("connect_client: accept failed (code %d)!\n", sErrno);
		return -1;
	}
	if( fd == 0 )
	{// reserved
		ShowError("connect_client: Socket #0 is reserved - Please report this!!!\n");
		sClose(fd);
		return -1;
	}
	if( fd >= FD_SETSIZE )
	{// socket number too big
		ShowError("connect_client: New socket #%d is greater than can we handle! Increase the value of FD_SETSIZE (currently %d) for your OS to fix this!\n", fd, FD_SETSIZE);
		sClose(fd);
		return -1;
	}

	//setsocketopts(fd);
	//set_nonblocking(fd, 1);

#ifndef MINICORE
	if( ip_rules && !connect_check(ntohl(client_address.sin_addr.s_addr)) ) {
		do_close(fd);
		return -1;
	}
#endif

	if( fd_max <= fd ) fd_max = fd + 1;
	sFD_SET(fd,&readfds);

	//create_session(fd, recv_to_fifo, send_from_fifo, default_func_parse);
	//session[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);

	return fd;
}

int32 makeListenBind_tcp(const char* ip, uint16 port,RecvFunc connect_client)
{
	struct sockaddr_in server_address;
	int fd;
	int result;

	fd = sSocket(AF_INET, SOCK_STREAM, 0);

	if( fd == -1 )
	{
		ShowError("make_listen_bind: socket creation failed (code %d)!\n", sErrno);
		do_final(EXIT_FAILURE);
	}
	if( fd == 0 )
	{// reserved
		ShowError("make_listen_bind: Socket #0 is reserved - Please report this!!!\n");
		sClose(fd);
		return -1;
	}
	if( fd >= FD_SETSIZE )
	{// socket number too big
		ShowError("make_listen_bind: New socket #%d is greater than can we handle! Increase the value of FD_SETSIZE (currently %d) for your OS to fix this!\n", fd, FD_SETSIZE);
		sClose(fd);
		return -1;
	}

	//setsocketopts(fd);
	//set_nonblocking(fd, 1);

    server_address.sin_family      = AF_INET;
    inet_pton(AF_INET, ip, &server_address.sin_addr.s_addr);
    server_address.sin_port        = htons(port);

	result = sBind(fd, (struct sockaddr*)&server_address, sizeof(server_address));
	if( result == SOCKET_ERROR ) {
		ShowError("make_listen_bind: bind failed (socket #%d, code %d)!\n", fd, sErrno);
        do_final(EXIT_FAILURE);
	}
	result = sListen(fd,5);
	if( result == SOCKET_ERROR ) {
		ShowError("make_listen_bind: listen failed (socket #%d, code %d)!\n", fd, sErrno);
        do_final(EXIT_FAILURE);
	}

	if(fd_max <= fd) fd_max = fd + 1;
	sFD_SET(fd, &readfds);

	create_session(fd, connect_client, null_send, null_parse);
	session[fd]->client_addr = 0; // just listens
	session[fd]->rdata_tick = 0; // disable timeouts on this socket

	return fd;
}

int32 RFIFOSKIP(int32 fd, size_t len)
{
	  struct socket_data *s;

	if ( !session_isActive(fd) )
		return 0;

	s = session[fd].get();

	if ( s->rdata.size() < s->rdata_pos + len ) {
		ShowError("RFIFOSKIP: skipped past end of read buffer! Adjusting from %d to %d (session #%d)\n", len, RFIFOREST(fd), fd);
		len = RFIFOREST(fd);
	}

	s->rdata_pos = s->rdata_pos + len;
	return 0;
}

void do_close_tcp(int32 fd)
{
	flush_fifo(fd);
	do_close(fd);
	if(session[fd])delete_session(fd);
}

int socket_config_read(const char* cfgName)
{
	char line[1024],w1[1024],w2[1024];
	FILE *fp;

	fp = fopen(cfgName, "r");
	if(fp == NULL) {
		ShowError("File not found: %s\n", cfgName);
		return 1;
	}

	while(fgets(line, sizeof(line), fp))
	{
		if(line[0] == '/' && line[1] == '/')
			continue;
		if(sscanf(line, "%[^:]: %[^\r\n]", w1, w2) != 2)
			continue;

		if (!strcmpi(w1, "stall_time"))
			stall_time = atoi(w2);
#ifndef MINICORE
		else if (!strcmpi(w1, "enable_ip_rules")) {
			ip_rules = config_switch(w2);
		} else if (!strcmpi(w1, "order")) {
			if (!strcmpi(w2, "deny,allow"))
				access_order = ACO_DENY_ALLOW;
			else if (!strcmpi(w2, "allow,deny"))
				access_order = ACO_ALLOW_DENY;
			else if (!strcmpi(w2, "mutual-failure"))
				access_order = ACO_MUTUAL_FAILURE;
		} else if (!strcmpi(w1, "allow")) {
            AccessControl acc{};
            if (access_ipmask(w2, &acc))
                access_allow.push_back(acc);
			else
				ShowError("socket_config_read: Invalid ip or ip range '%s'!\n", line);
		} else if (!strcmpi(w1, "deny")) {
            AccessControl acc{};
            if (access_ipmask(w2, &acc))
                access_deny.push_back(acc);
			else
				ShowError("socket_config_read: Invalid ip or ip range '%s'!\n", line);
		}
		else if (!strcmpi(w1,"ddos_interval"))
			ddos_interval = std::chrono::milliseconds(atoi(w2));
		else if (!strcmpi(w1,"ddos_count"))
			ddos_count = atoi(w2);
		else if (!strcmpi(w1,"ddos_autoreset"))
			ddos_autoreset = std::chrono::milliseconds(atoi(w2));
		else if (!strcmpi(w1,"debug"))
			access_debug = config_switch(w2);
#endif
		else if (!strcmpi(w1, "import"))
			socket_config_read(w2);
	}

	fclose(fp);
	return 0;
}

void socket_init_tcp(void)
{
	if(!_vsocket_init())
		return;

    const char *SOCKET_CONF_FILENAME = "./conf/packet_tcp.conf";
	socket_config_read(SOCKET_CONF_FILENAME);
	// session[0] is now currently used for disconnected sessions of the map server, and as such,
	// should hold enough buffer (it is a vacuum so to speak) as it is never flushed. [Skotlex]
	create_session(0, null_recv, null_send, null_parse);

#ifndef MINICORE
	// Delete old connection history every 5 minutes
	memset(connect_history, 0, sizeof(connect_history));
	CTaskMgr::getInstance()->AddTask("connect_check_clear",server_clock::now()+1s,NULL,CTaskMgr::TASK_INTERVAL,connect_check_clear,5min);

#endif
}

void socket_final_tcp(void)
{
	if(!_vsocket_final())
		return;
	int i;
#ifndef MINICORE
	ConnectHistory* hist;
	ConnectHistory* next_hist;

	for( i=0; i < 0x10000; ++i ){
		hist = connect_history[i];
		while( hist ){
			next_hist = hist->next;
			delete hist;
			hist = next_hist;
		}
	}
#endif

	for( i = 1; i < fd_max; i++ )
		if(session[i])
			do_close_tcp(i);
}

void flush_fifo(int32 fd)
{
	if(session[fd] != NULL)
		session[fd]->func_send(fd);
}

void flush_fifos(void)
{
	int i;
	for(i = 1; i < fd_max; i++)
		flush_fifo(i);
}

void set_defaultparse(ParseFunc defaultparse)
{
	default_func_parse = defaultparse;
}

void set_eof(int32 fd)
{
	if( session_isActive(fd) )
	{
		session[fd]->flag.eof = 1;
	}
}

int create_session(int fd, RecvFunc func_recv, SendFunc func_send, ParseFunc func_parse)
{
	session[fd] = std::make_unique<socket_data>();
    session[fd]->rdata.reserve(RFIFO_SIZE);
    session[fd]->wdata.reserve(WFIFO_SIZE);

	session[fd]->func_recv  = func_recv;
	session[fd]->func_send  = func_send;
	session[fd]->func_parse = func_parse;
	session[fd]->rdata_tick = last_tick;
	return 0;
}

int delete_session(int fd)
{
	if (fd <= 0 || fd >= FD_SETSIZE)
		return -1;
	return 0;
}

/*======================================
 *	CORE : Socket options
 *--------------------------------------*/
void set_nonblocking(int fd, unsigned long yes)
{
	// FIONBIO Use with a nonzero argp parameter to enable the nonblocking mode of socket s.
	// The argp parameter is zero if nonblocking is to be disabled.
	if( sIoctl(fd, FIONBIO, &yes) != 0 )
		ShowError("set_nonblocking: Failed to set socket #%d to non-blocking mode (code %d) - Please report this!!!\n", fd, sErrno);
}

/*
*
*			UDP LEVEL
*
*/
int32 makeBind_udp(uint32 ip, uint16 port)
{
	struct sockaddr_in server_address;
	int fd;
	int result;

	fd = sSocket(AF_INET, SOCK_DGRAM, 0);

	if( fd == -1 )
	{
		ShowError("make_listen_bind: socket creation failed (code %d)!\n", sErrno);
        do_final(EXIT_FAILURE);
	}
	if( fd == 0 )
	{// reserved
		ShowError("make_listen_bind: Socket #0 is reserved - Please report this!!!\n");
		sClose(fd);
		return -1;
	}
	if( fd >= FD_SETSIZE )
	{// socket number too big
		ShowError("make_listen_bind: New socket #%d is greater than can we handle! Increase the value of FD_SETSIZE (currently %d) for your OS to fix this!\n", fd, FD_SETSIZE);
		sClose(fd);
		return -1;
	}

	server_address.sin_family      = AF_INET;
	server_address.sin_addr.s_addr = htonl(ip);
	server_address.sin_port        = htons(port);

	result = sBind(fd, (struct sockaddr*)&server_address, sizeof(server_address));
	if( result == SOCKET_ERROR )
    {
		ShowError("make_listen_bind: bind failed (socket #%d, code %d)!\n", fd, sErrno);
        do_final(EXIT_FAILURE);
	}

	if(fd_max <= fd) fd_max = fd + 1;
	sFD_SET(fd, &readfds);
	return fd;
}

void socket_init_udp(void)
{
	if(!_vsocket_init())
		return;
    const char * SOCKET_CONF_FILENAME = "./conf/packet_udp.conf";
	socket_config_read(SOCKET_CONF_FILENAME);
}

void do_close_udp(int32 fd)
{
	do_close(fd);
}

void socket_final_udp(void)
{
	if( !_vsocket_final() )
		return;
	//do_close_udp(listen_fd);
}

int32 recvudp(int32 fd,void *buff,size_t nbytes,int32 flags,struct sockaddr *from, socklen_t *addrlen)
{
	return sRecvfrom(fd,(char*)buff,(int)nbytes,flags,from,addrlen);
}

int32 sendudp(int32 fd,void *buff,size_t nbytes,int32 flags,const struct sockaddr *from,socklen_t addrlen)
{
	return sSendto(fd,(const char*)buff,(int)nbytes,flags,from,addrlen);
}

void socket_init()
{
    switch (SOCKET_TYPE)
    {
    case socket_type::TCP:
        socket_init_tcp();
        break;
    case socket_type::UDP:
        socket_init_udp();
        break;
    default:
        break;
    }
}

void socket_final()
{
    switch (SOCKET_TYPE)
    {
    case socket_type::TCP:
        socket_final_tcp();
        break;
    case socket_type::UDP:
        socket_final_udp();
        break;
    default:
        break;
    }
}
