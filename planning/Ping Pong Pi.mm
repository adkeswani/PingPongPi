<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1431298320727" ID="ID_1801434271" MODIFIED="1431298567938" TEXT="Ping Pong Pi">
<node CREATED="1431299663967" ID="ID_530804312" MODIFIED="1431814640274" POSITION="right" TEXT="motion to website interface">
<node CREATED="1431299681906" ID="ID_1567186222" MODIFIED="1431299694731" TEXT="Could use a text file and then just have the website code read that"/>
<node CREATED="1431299694915" ID="ID_1732103164" MODIFIED="1431299704285" TEXT="But that creates a tight dependency between them"/>
<node CREATED="1431299723920" ID="ID_317925435" MODIFIED="1431814644953" TEXT="Instead, have the website expose an interface that motion can use to pass in updates">
<font NAME="SansSerif" SIZE="12"/>
</node>
<node CREATED="1436048732987" ID="ID_1190066321" MODIFIED="1436048806765" TEXT="Should motion maintain a variable holding the last capture time that was sent to the service? That would avoid the round trip of sending it to the service to ask. Yes, good."/>
<node CREATED="1436048810312" ID="ID_1982464318" MODIFIED="1436048841268" TEXT="But for the first-start case, we still need a way to know what the last update time was from the service"/>
<node CREATED="1436048841423" ID="ID_1154661304" MODIFIED="1436048867710" TEXT="OK, so we would get that via a GET on /lastCapture/time">
<node CREATED="1436048967804" ID="ID_494122225" MODIFIED="1436048973116" TEXT="This would return via JSON"/>
</node>
<node CREATED="1436048973827" ID="ID_1764177320" MODIFIED="1436048990661" TEXT="Then we would do a POST on /lastCapture, with a URL encoded timestamp">
<node CREATED="1436048993237" ID="ID_1481042172" MODIFIED="1436049002507" TEXT="If the timestamp is &lt; last capture&apos;s stamp, we would return an error"/>
</node>
<node CREATED="1436661620746" ID="ID_1853679877" MODIFIED="1436661628888" TEXT="Where will the last capture time be stored?">
<node CREATED="1436661629690" ID="ID_983296941" MODIFIED="1436661649152" TEXT="Should it be the last modified time of the image file? I think that&apos;s a bit unsafe."/>
<node CREATED="1436661649347" ID="ID_1267475203" MODIFIED="1436661659516" TEXT="If we use a separate file, is it better?"/>
<node CREATED="1436661763663" ID="ID_1219696568" MODIFIED="1436661771219" TEXT="So it would be a text file containing the last modified time?"/>
<node CREATED="1436661806272" ID="ID_219636660" MODIFIED="1436661809627" TEXT="Yes, it&apos;s less fragile"/>
<node CREATED="1437874687030" ID="ID_209364264" MODIFIED="1437874700087" TEXT="Hmm...if so, then why are we using last modified time of file in other places?"/>
<node CREATED="1437874700337" ID="ID_143550189" MODIFIED="1437874738573" TEXT="Should we place a reliance on last modified time or not, that&apos;s the main question"/>
<node CREATED="1437874838165" ID="ID_1993307836" MODIFIED="1437874932332" TEXT="When we pass a file across, should we depend on it?"/>
<node CREATED="1437874952511" ID="ID_1700806203" MODIFIED="1437874961877" TEXT="It is fragile on the server and I&apos;m thinking also on the client side"/>
</node>
<node CREATED="1436662201063" ID="ID_174449131" MODIFIED="1436662205966" TEXT="How are we going to pass the time around?">
<node CREATED="1436664710530" ID="ID_882291964" MODIFIED="1436664716810" TEXT="Going to use milliseconds since epch"/>
</node>
<node CREATED="1436664717702" ID="ID_1756770794" MODIFIED="1436664722653" TEXT="Testing...">
<node CREATED="1436664723362" ID="ID_256507706" MODIFIED="1436664727218" TEXT="Unit test?"/>
<node CREATED="1436664728305" ID="ID_1053448036" MODIFIED="1436664738648" TEXT="Functional test?"/>
<node CREATED="1436664819712" ID="ID_119969326" MODIFIED="1436664827584" TEXT="We can write a test that tests the interface to the site"/>
<node CREATED="1436664848304" ID="ID_565523087" MODIFIED="1436664858019" TEXT="OR we can write a unit test for the methods inside the file..."/>
<node CREATED="1436665350657" ID="ID_1765236532" MODIFIED="1436665362506" TEXT="We&apos;ve been doing "/>
</node>
</node>
<node CREATED="1431301430942" ID="ID_454370266" MODIFIED="1433114316031" POSITION="right" TEXT="motion detect (the thing that sends updates to the site)">
<node CREATED="1433114316010" ID="ID_467325129" MODIFIED="1433114317244" TEXT="Notes">
<node CREATED="1431299743861" FOLDED="true" ID="ID_497474240" MODIFIED="1431301002507" TEXT="Option 1: knowing when the table is in use/not in use">
<node CREATED="1431299797101" ID="ID_706497313" MODIFIED="1431299802189" TEXT="We detect motion"/>
<node CREATED="1431299802404" ID="ID_1833167761" MODIFIED="1431299817294" TEXT="How much consecutive motion does there have to be before we deem the table in use"/>
<node CREATED="1431299817478" ID="ID_1327404940" MODIFIED="1431299834567" TEXT="And once motion stops, how long does it have to stop for before we deem it not in use"/>
<node CREATED="1431299835925" ID="ID_478298435" MODIFIED="1431299933214" TEXT="We have motion start and motion stop events that can trigger any command"/>
<node CREATED="1431300216416" ID="ID_995862606" MODIFIED="1431300230496" TEXT="Suppose we get a motion start and then a stop. That&apos;s one event, I guess"/>
<node CREATED="1431300232220" ID="ID_214097437" MODIFIED="1431300247094" TEXT="And then we should wait and see if there&apos;s another event within N seconds">
<node CREATED="1431300248025" ID="ID_302447580" MODIFIED="1431300259243" TEXT="If so, that indicates the table is in use"/>
<node CREATED="1431300259418" ID="ID_103479830" MODIFIED="1431300267019" TEXT="If not, the table is not in use"/>
</node>
<node CREATED="1431300386975" ID="ID_371393747" MODIFIED="1431300391579" TEXT="Do we need a second daemon then?">
<node CREATED="1431300392622" ID="ID_158453542" MODIFIED="1431300398413" TEXT="One is the motion capture itself"/>
<node CREATED="1431300398601" ID="ID_612539389" MODIFIED="1431300414512" TEXT="The second will receive notifications of events"/>
</node>
<node CREATED="1431300420183" ID="ID_1185619612" MODIFIED="1431300434113" TEXT="Second daemon">
<node CREATED="1431300434839" ID="ID_625147600" MODIFIED="1431300454529" TEXT="Receives events"/>
<node CREATED="1431300454741" ID="ID_979591803" MODIFIED="1431300467248" TEXT="If it receives M events in a row, that means table is in use?"/>
<node CREATED="1431300467472" ID="ID_1977853151" MODIFIED="1431300479098" TEXT="If it stops receiving events, table is not in use"/>
</node>
<node CREATED="1431300497836" ID="ID_963302257" MODIFIED="1431300503339" TEXT="Potential problem">
<node CREATED="1431300503969" ID="ID_1050588242" MODIFIED="1431300509859" TEXT="What if movement is continuous?"/>
<node CREATED="1431300510209" ID="ID_341057120" MODIFIED="1431300521891" TEXT="We can&apos;t rely on start-stop pairs, must be a combination"/>
<node CREATED="1431300522098" ID="ID_902961420" MODIFIED="1431300579855" TEXT="So if we receive a start and then no stop for many seconds, that also indicates table is in use"/>
</node>
</node>
<node CREATED="1431300623595" FOLDED="true" ID="ID_679170454" MODIFIED="1431301001720" TEXT="Option 2: Hmm, maybe overcomplicating this">
<node CREATED="1431300629117" ID="ID_480503209" MODIFIED="1431300665450" TEXT="Suppose every time we detect motion, we just update the page with the latest photo"/>
<node CREATED="1431300665706" ID="ID_1024756827" MODIFIED="1431300689957" TEXT="And leave it to the user to determine if the table is in use"/>
<node CREATED="1431300703267" ID="ID_1644936425" MODIFIED="1431300711335" TEXT="And then display a &quot;last motion detected&quot; time"/>
<node CREATED="1431300715505" ID="ID_929734140" MODIFIED="1431300790636" TEXT="If that last motion was quite a while ago, user knows the table isn&apos;t in use"/>
<node CREATED="1431300804144" ID="ID_1588635649" MODIFIED="1431300817846" TEXT="And we can perhaps display more than one event"/>
</node>
<node CREATED="1431300916891" ID="ID_1457805691" MODIFIED="1431300957587" TEXT="Option 2 definitely seems easier, more sensible"/>
<node CREATED="1431300959097" FOLDED="true" ID="ID_1914375467" MODIFIED="1433110661982" TEXT="More details on option 2">
<node CREATED="1431300998883" ID="ID_524738396" MODIFIED="1431301031302" TEXT="Table is in use, so we receive a motion started event">
<node CREATED="1431301080364" ID="ID_495792526" MODIFIED="1431301089806" TEXT="We call some command that triggers us to update the website"/>
</node>
<node CREATED="1431301031550" ID="ID_1796029173" MODIFIED="1431301096630" TEXT="Do we update with the very first motion frame?">
<node CREATED="1431301151305" ID="ID_150830856" MODIFIED="1431301165969" TEXT="Maybe let&apos;s sleep for N seconds and then pick up the latest image, whatever that might be"/>
<node CREATED="1431301384425" ID="ID_63399386" MODIFIED="1431301395264" TEXT="The time we use will be when the motion was first detected though"/>
</node>
<node CREATED="1431301047228" ID="ID_1768320062" MODIFIED="1431301074395" TEXT="Motion stops and we receive another motion started event">
<node CREATED="1431301174176" ID="ID_1975061826" MODIFIED="1431301178162" TEXT="Just do the same thing again"/>
</node>
</node>
<node CREATED="1431301934579" FOLDED="true" ID="ID_87173671" MODIFIED="1431814153083" TEXT="Can we use events?">
<node CREATED="1431301938785" ID="ID_1221165039" MODIFIED="1431301947768" TEXT="An event ends when there hasn&apos;t been motion for N seconds"/>
<node CREATED="1431301947960" ID="ID_699381083" MODIFIED="1431301966927" TEXT="And then next time motion is detected, that&apos;s when the next event starts"/>
<node CREATED="1431302143609" ID="ID_304552885" MODIFIED="1431302158199" TEXT="I suppose that would help us avoid updating the website too often, yes..."/>
<node CREATED="1431302643691" ID="ID_463377909" MODIFIED="1431302646482" TEXT="This will be tuned"/>
<node CREATED="1431302651281" ID="ID_521011304" MODIFIED="1431302692912" TEXT="But suppose we make it 5 seconds. If there&apos;s no motion in those 5 seconds, the event stops, and the next time we see motion, we will update the website"/>
</node>
<node CREATED="1431302984547" FOLDED="true" ID="ID_1776791336" MODIFIED="1431815242310" TEXT="We either use events or just motion start">
<node CREATED="1431814248152" ID="ID_1548584469" MODIFIED="1431814411120" TEXT="If we use events and the player stop then start, we won&apos;t change the site"/>
<node CREATED="1431814411374" ID="ID_1334615839" MODIFIED="1431814428763" TEXT="If we use motion start, then if the players stop, we will change on the next movement"/>
<node CREATED="1431814438016" ID="ID_1437065134" MODIFIED="1431814609623" TEXT="We should use motion start stop, because otherwise we might not update often enough!"/>
<node CREATED="1431815069853" ID="ID_511202920" MODIFIED="1431815086432" TEXT="Ach, we only have a motion detected event, not motion start/stop"/>
<node CREATED="1431815086640" ID="ID_1316388132" MODIFIED="1431815090057" TEXT="So we&apos;ll have to use events"/>
<node CREATED="1431815090249" ID="ID_1598779508" MODIFIED="1431815100894" TEXT="Let&apos;s go with a short gap then"/>
</node>
<node CREATED="1431815242775" FOLDED="true" ID="ID_1836167265" MODIFIED="1433110660983" TEXT="Event started script">
<node CREATED="1431815247410" ID="ID_1961286635" MODIFIED="1431815262144" TEXT="We want to sleep for a second, then send the latest image to the site"/>
<node CREATED="1431815262351" ID="ID_999869758" MODIFIED="1431815275908" TEXT="But what if we get multiple events while the command is running?"/>
<node CREATED="1431815426112" ID="ID_1157218411" MODIFIED="1431815432348" TEXT="We could come up with locking somehow"/>
<node CREATED="1431815432556" ID="ID_94112502" MODIFIED="1431815447197" TEXT="Or we could just do it in parallel"/>
<node CREATED="1431816887246" ID="ID_806162465" MODIFIED="1431816887817" TEXT="http://jdimpson.livejournal.com/5685.html">
<node CREATED="1431816890299" ID="ID_567281849" MODIFIED="1431816891642" TEXT="Locking"/>
</node>
</node>
<node CREATED="1433110630092" ID="ID_652130976" MODIFIED="1433110659493" TEXT="Make the event started script into a command (add to path maybe?), and that way we don&apos;t need to worry about where motion is runnin">
<node CREATED="1433112908648" ID="ID_376397953" MODIFIED="1433112920858" TEXT="Hmm, the lock locations will need to be changed"/>
</node>
<node CREATED="1433110672683" FOLDED="true" ID="ID_378938817" MODIFIED="1433114311278" TEXT="Thinking about events">
<node CREATED="1433110675939" ID="ID_948237146" MODIFIED="1433110686621" TEXT="So if we don&apos;t detect motion for 3 seconds, that becomes a new event"/>
<node CREATED="1433110705344" ID="ID_635794757" MODIFIED="1433110756444" TEXT="And so we&apos;ll wait for one second, then we&apos;ll get the latest image"/>
<node CREATED="1433110782447" ID="ID_449289143" MODIFIED="1433110799228" TEXT="We won&apos;t receive another event-started until the next time there&apos;s motion"/>
<node CREATED="1433110799427" ID="ID_1178537768" MODIFIED="1433110813388" TEXT="What if there&apos;s constant movement? Doesn&apos;t that mean we&apos;d never update the site?"/>
<node CREATED="1433111713199" ID="ID_981251904" MODIFIED="1433111764010" TEXT="Okay, so should we have an eventStopped script too?"/>
<node CREATED="1433111764209" ID="ID_589394820" MODIFIED="1433111779535" TEXT="While there is motion, we keep updating the site every minute?"/>
</node>
<node CREATED="1433111109724" FOLDED="true" ID="ID_353117445" MODIFIED="1433114311646" TEXT="Do we actually need to use motion detect?">
<node CREATED="1433111118099" ID="ID_892736896" MODIFIED="1433111130883" TEXT="Not really. We could update once a minute. But motion detect is kinda cool"/>
<node CREATED="1433111278057" ID="ID_93960204" MODIFIED="1433111290542" TEXT="It also saves power and bandwidth"/>
</node>
<node CREATED="1433112248367" FOLDED="true" ID="ID_3527737" MODIFIED="1433114311968" TEXT="So how will we present the information?">
<node CREATED="1433112254468" ID="ID_1089356186" MODIFIED="1433112366241" TEXT="Sure we can say motion was detected at X time when an event starts"/>
<node CREATED="1433112366456" ID="ID_526331114" MODIFIED="1433112373623" TEXT="And then as the event continues, we just update that?"/>
<node CREATED="1433112555534" ID="ID_1005121236" MODIFIED="1433112568574" TEXT="Motion started at X, continued at Y?"/>
<node CREATED="1433112619474" ID="ID_1525176732" MODIFIED="1433112624139" TEXT="Yes, that&apos;s an OK string"/>
</node>
<node CREATED="1433112954775" FOLDED="true" ID="ID_1683777084" MODIFIED="1433114312290" TEXT="Event stopped">
<node CREATED="1433112958289" ID="ID_1403957122" MODIFIED="1433112962008" TEXT="What exactly will this do?"/>
<node CREATED="1433112963113" ID="ID_190659811" MODIFIED="1433112976663" TEXT="It needs to signal event started that the event has finished"/>
<node CREATED="1433113031943" ID="ID_1781314018" MODIFIED="1433113038331" TEXT="We could do that using a file of some sort"/>
<node CREATED="1433114091205" ID="ID_1910566151" MODIFIED="1433114100804" TEXT="Or using (named/anonymous) pipes"/>
</node>
<node CREATED="1433114308190" ID="ID_1503710909" MODIFIED="1433114413014" TEXT="Is it possible for us to get multiple event-started at the same time? Shouldn&apos;t be...">
<node CREATED="1433114415852" ID="ID_1537444555" MODIFIED="1433114431119" TEXT="But could we still be running an event-started when another one comes in? Potentially."/>
</node>
<node CREATED="1433638220819" FOLDED="true" ID="ID_1041631869" MODIFIED="1433645712950" TEXT="Still questioning the motion detect...">
<node CREATED="1433639336269" ID="ID_1033219909" MODIFIED="1433640519499" TEXT="Should we just do plain webcam?"/>
<node CREATED="1433640558826" ID="ID_1313780214" MODIFIED="1433640567119" TEXT="Nah, stick with motion detect. It&apos;s more interesting"/>
</node>
<node CREATED="1433642917217" FOLDED="true" ID="ID_1298161441" MODIFIED="1433645713287" TEXT="We&apos;re sort of dependent upon seeing the end event">
<node CREATED="1433642962844" ID="ID_147632571" MODIFIED="1433642975015" TEXT="If we don&apos;t see that, we&apos;ll just keep updating the site, and that&apos;s not good..."/>
<node CREATED="1433643011164" ID="ID_1724427912" MODIFIED="1433643030441" TEXT="Is there any way we can cope with that?"/>
<node CREATED="1433643046824" ID="ID_859943319" MODIFIED="1433643051470" TEXT="Let&apos;s assume that it&apos;s reliable"/>
<node CREATED="1433643183489" ID="ID_577848422" MODIFIED="1433643212944" TEXT="What if we get an event start, then and event end, and before that completes, we get another event start - we&apos;ll miss that"/>
<node CREATED="1433643339797" ID="ID_190321798" MODIFIED="1433643352024" TEXT="Hmm. Instead, if we capture a frame each time there&apos;s motion">
<node CREATED="1433643352215" ID="ID_1014127613" MODIFIED="1433643383196" TEXT="And then have a long-running process that just gets the latest capture, compares it to what we already have on the site, and updates if necessary..."/>
<node CREATED="1433643415305" ID="ID_1113821827" MODIFIED="1433643443913" TEXT="We avoid any locking nonsense, no events needed, and we still only update when we see motion..."/>
</node>
</node>
<node CREATED="1433114242811" FOLDED="true" ID="ID_605216001" MODIFIED="1433645713600" TEXT="Old Solution">
<node CREATED="1433114260782" ID="ID_1653737247" MODIFIED="1433114265088" TEXT="Event started, we update the site"/>
<node CREATED="1433114265284" ID="ID_279699854" MODIFIED="1433114282099" TEXT="Event started continues to update the site every N seconds"/>
<node CREATED="1433114282291" ID="ID_1366852392" MODIFIED="1433114296279" TEXT="Event ends, we tell event started to stop via a pipe"/>
</node>
<node CREATED="1433645454585" ID="ID_76504119" MODIFIED="1433645584441" TEXT="Now, is it the site&apos;s responsibility to track capture times? Or will the motion script do it?">
<node CREATED="1433645554930" ID="ID_1548574691" MODIFIED="1433645579666" TEXT="Well, maybe the site wants to show the last 2 images. In that case, it&apos;s sthe site&apos;s responsibility"/>
<node CREATED="1433645610876" ID="ID_996592868" MODIFIED="1433645631615" TEXT="But do we really want to upload to the site every N seconds? That seems wasteful..."/>
<node CREATED="1433645882266" ID="ID_263761962" MODIFIED="1433645901240" TEXT="It makes sense for the site to tell us if it wants this image rather than us trying to decide from the motion capture side."/>
<node CREATED="1433645905338" ID="ID_1604934329" MODIFIED="1433645916085" TEXT="That way they&apos;re totally decoupled, just dependent on the interface"/>
</node>
<node CREATED="1433716052133" ID="ID_732994300" MODIFIED="1433716054860" TEXT="Use node.js?">
<node CREATED="1433716055649" ID="ID_830805799" MODIFIED="1433716096766" TEXT="Simple to set up, as opposed to apache?"/>
<node CREATED="1433716756435" ID="ID_1888724660" MODIFIED="1433716791137" TEXT="Won&apos;t do extra stuff that apache would normally do, throttling etc."/>
<node CREATED="1433717460630" ID="ID_115530820" MODIFIED="1433717462708" TEXT="Try it and see"/>
</node>
</node>
<node CREATED="1433114555656" ID="ID_126664002" MODIFIED="1433114558044" TEXT="Open questions">
<node CREATED="1433114558920" ID="ID_1528912036" MODIFIED="1433640672817" TEXT="If we have a flock, will it automatically get released on process exit?">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1433114844586" ID="ID_1281082419" MODIFIED="1433116709368" TEXT="Getting an unused FD">
<icon BUILTIN="button_ok"/>
<node CREATED="1433114849142" ID="ID_1818404305" LINK="http://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;uact=8&amp;ved=0CB8QFjAA&amp;url=http%3A%2F%2Flinux.die.net%2Fman%2F2%2Fexit&amp;ei=95JrVeXgCYfeoASftYKQCw&amp;usg=AFQjCNHEAISB5Se7Ltwh_aZ61KkWDjXqUw&amp;sig2=uyMERu7MnlvzVhcdgRUxlw&amp;bvm=bv.94455598" MODIFIED="1433114849142" TEXT="google.com &gt; Url ? ..."/>
<node CREATED="1433116573499" ID="ID_541870837" MODIFIED="1433116587765" TEXT="Each shell gets its own set of FDs, I think"/>
<node CREATED="1433116587964" ID="ID_1653087681" MODIFIED="1433116600939" TEXT="We should be able to test this"/>
<node CREATED="1433116692286" ID="ID_128717125" MODIFIED="1433116697032" TEXT="Tested, works with this approach"/>
</node>
</node>
<node CREATED="1433645443591" ID="ID_412616605" MODIFIED="1433645444910" TEXT="Solution">
<node CREATED="1433645445596" ID="ID_1409640841" MODIFIED="1433645454305" TEXT="Get latest capture from captures dir"/>
</node>
<node CREATED="1434937683269" ID="ID_528108938" MODIFIED="1434937684261" TEXT="Problem">
<node CREATED="1434937685195" ID="ID_444145060" MODIFIED="1434939225748" TEXT="If the file creates are too close together, ls doesn&apos;t always return the correct one (resolution isn&apos;t small enough)">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1434937705841" ID="ID_865193749" MODIFIED="1434939225748" TEXT="If we rely on the filename, that creates a tight dependency, no?">
<icon BUILTIN="button_ok"/>
<node CREATED="1434939215295" ID="ID_1965479041" MODIFIED="1434939219119" TEXT="Meh, used it. Fixed now"/>
</node>
<node CREATED="1434937905651" ID="ID_235970445" MODIFIED="1434937933169" TEXT="We can always transform the timestamp when we pass across to the website"/>
<node CREATED="1434938101584" ID="ID_1642271525" MODIFIED="1434938108616" TEXT="Also, do we need to reintroduce locking?">
<node CREATED="1434938437211" ID="ID_604657359" MODIFIED="1434938448026" TEXT="What if something hangs, or just takes a little longer than usual?"/>
</node>
<node CREATED="1434938457828" ID="ID_1656352208" MODIFIED="1434938479260" TEXT="What if another file gets added while we&apos;re processing? We might delete that..."/>
</node>
</node>
<node CREATED="1431301460459" ID="ID_1634956536" MODIFIED="1431301461589" POSITION="right" TEXT="the site">
<node CREATED="1435538954577" ID="ID_892897153" MODIFIED="1435538973181" TEXT="So we&apos;ll probably use a bunch of URLs for the different actions..."/>
<node CREATED="1435539378414" ID="ID_350308611" MODIFIED="1435539423046" TEXT="Thinking of having a LastCapture object that we can get/set. It will remain in memory, but we will also write to file, so next time server starts up we can use it"/>
</node>
</node>
</map>
