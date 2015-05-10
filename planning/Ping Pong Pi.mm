<map version="0.9.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1431298320727" ID="ID_1801434271" MODIFIED="1431298567938" TEXT="Ping Pong Pi">
<node CREATED="1431299663967" FOLDED="true" ID="ID_530804312" MODIFIED="1431301003024" POSITION="right" TEXT="motion to website interface">
<node CREATED="1431299681906" ID="ID_1567186222" MODIFIED="1431299694731" TEXT="Could use a text file and then just have the website code read that"/>
<node CREATED="1431299694915" ID="ID_1732103164" MODIFIED="1431299704285" TEXT="But that creates a tight dependency between them"/>
<node CREATED="1431299723920" ID="ID_317925435" MODIFIED="1431299742917" TEXT="Instead, have the website expose an interface that motion can use to pass in updates"/>
</node>
<node CREATED="1431301430942" ID="ID_454370266" MODIFIED="1431301454669" POSITION="right" TEXT="motion detect (the thing that sends updates to the site)">
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
<node CREATED="1431300959097" ID="ID_1914375467" MODIFIED="1431300997990" TEXT="More details on option 2">
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
</node>
<node CREATED="1431301460459" ID="ID_1634956536" MODIFIED="1431301461589" POSITION="right" TEXT="the site"/>
</node>
</map>
