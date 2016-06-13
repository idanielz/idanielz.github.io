//
//  main.m
//  UpdateHosts
//
//  Created by 张继东 on 16/5/23.
//  Copyright © 2016年 idanielz. All rights reserved.
//

#import <Foundation/Foundation.h>

static BOOL isEnd;
static void moveToEtcPath()
{
    NSDictionary *error = [NSDictionary new];
    NSString *script =  @"do shell script \"cp ~/Desktop/hosts /etc/hosts;chown root:wheel /etc/hosts\" with administrator privileges";
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
    if ([appleScript executeAndReturnError:&error]) {
        NSLog(@"success!");
    } else {
        NSLog(@"failure!");
    }
}

static void createHostConfig()
{
    NSDate *date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr= [[formatter stringFromDate:date]stringByAppendingString:@".conf"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:dateStr isDirectory:NO]) {
        [[NSFileManager defaultManager]removeItemAtPath:dateStr error:nil];
    }
    NSDictionary *error = [NSDictionary new];
    NSString *script =  @"do shell script \"perl -pi -e 's/\r\n|\n|\r/\n/g' ~/Desktop/hosts;grep '^[0-9]' ~/Desktop/hosts|sed '/^127/d'|sed '/^255/d' > ~/Desktop/zjdtmpHost.conf\"";
    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:script];
    if ([appleScript executeAndReturnError:&error]) {
        NSLog(@"success!");
    } else {
        NSLog(@"failure!");
    }
    NSString *str = [NSString stringWithFormat:@"cat ~/Desktop/test.conf > ~/Desktop/%@; awk '{print $2 \\\" = \\\" $1}' ~/Desktop/zjdtmpHost.conf >> ~/Desktop/%@;rm ~/Desktop/zjdtmpHost.conf;rm ~/Desktop/test.conf;open ~/Desktop;",dateStr, dateStr];
    NSString *script2 = [NSString stringWithFormat:@"do shell script \"%@\"", str];
    NSAppleScript *appleScript2 = [[NSAppleScript alloc] initWithSource:script2];
    if ([appleScript2 executeAndReturnError:&error]) {
        NSLog(@"success!");
        sleep(5);
    } else {
        NSLog(@"failure!");
        sleep(10);
    }
}
static void downloadHostsFile()
{
    NSLog(@"\n*********************修改Mac Hosts**********************\n"
          "*****************增加surge使用的配置文件******************\n"
          "*************************在你的桌面**********************\n"
          "****************CopyRight © 2016 张继东 ****************\n");
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/racaljk/hosts/master/hosts"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败, 网络问题, hosts文件无法下载https://raw.githubusercontent.com/racaljk/hosts/master/hosts\n%@",error.description);
            isEnd = YES;
        }
        else{
            NSString *tmpPath = [[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"hosts"];
            if ([[NSFileManager defaultManager]fileExistsAtPath:tmpPath isDirectory:NO]) {
                [[NSFileManager defaultManager]removeItemAtPath:tmpPath error:&error];
                if (error) {
                    NSLog(@"%@", error.description);
                }
            }
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:tmpPath] error:&error];
            if (error) {
                NSLog(@"%@", error.description);
            }
            else{
                moveToEtcPath();
                createHostConfig();
            }
            isEnd = YES;
        }
    }];
    [task resume];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        isEnd = NO;
        NSString *str = @"[General]\n"
        "skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local\n"
        "bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12\n"
        "loglevel = warning\n"
        "bypass-system = true\n"
        "dns-server = 114.114.114.114,119.29.29.29,8.8.8.8\n"
        "\n"
        "[Rule]\n"
        "DOMAIN,ad.api.3g.tudou.com,REJECT\n"
        "DOMAIN,ad.api.3g.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,atm.youku.com,REJECT\n"
        "DOMAIN-KEYWORD,admaster,REJECT\n"
        "DOMAIN-KEYWORD,adsage,REJECT\n"
        "DOMAIN-KEYWORD,adsmogo,REJECT\n"
        "DOMAIN-KEYWORD,adsrvmedia,REJECT\n"
        "DOMAIN-KEYWORD,clkservice,REJECT\n"
        "DOMAIN-KEYWORD,cnzz,REJECT\n"
        "DOMAIN-KEYWORD,counter,REJECT\n"
        "DOMAIN-KEYWORD,domob,REJECT\n"
        "DOMAIN-KEYWORD,duomeng,REJECT\n"
        "DOMAIN-KEYWORD,feedback,REJECT\n"
        "DOMAIN-KEYWORD,float,REJECT\n"
        "DOMAIN-KEYWORD,openx,REJECT\n"
        "DOMAIN-KEYWORD,tongji,REJECT\n"
        "DOMAIN-KEYWORD,umeng,REJECT\n"
        "DOMAIN-KEYWORD,usage,REJECT\n"
        "DOMAIN-SUFFIX,51.la,REJECT\n"
        "DOMAIN-SUFFIX,99click.com,REJECT\n"
        "DOMAIN-SUFFIX,acjs.aliyun.com,REJECT\n"
        "DOMAIN-SUFFIX,acs86.com,REJECT\n"
        "DOMAIN-SUFFIX,ad.3.cn,REJECT\n"
        "DOMAIN-SUFFIX,ad.thepaper.cn,REJECT\n"
        "DOMAIN-SUFFIX,ad.unimhk.com,REJECT\n"
        "DOMAIN-SUFFIX,adchina.com,REJECT\n"
        "DOMAIN-SUFFIX,adcome.cn,REJECT\n"
        "DOMAIN-SUFFIX,adform.net,REJECT\n"
        "DOMAIN-SUFFIX,adinfuse.com,REJECT\n"
        "DOMAIN-SUFFIX,adjust.com,REJECT\n"
        "DOMAIN-SUFFIX,adlive.cn,REJECT\n"
        "DOMAIN-SUFFIX,adm.easou.com,REJECT\n"
        "DOMAIN-SUFFIX,admin5.com,REJECT\n"
        "DOMAIN-SUFFIX,admob.com,REJECT\n"
        "DOMAIN-SUFFIX,admon.cn,REJECT\n"
        "DOMAIN-SUFFIX,adnxs.com,REJECT\n"
        "DOMAIN-SUFFIX,ads.genieessp.com,REJECT\n"
        "DOMAIN-SUFFIX,ads.mobclix.com,REJECT\n"
        "DOMAIN-SUFFIX,ads.yahoo.com,REJECT\n"
        "DOMAIN-SUFFIX,adsame.com,REJECT\n"
        "DOMAIN-SUFFIX,aduu.cn,REJECT\n"
        "DOMAIN-SUFFIX,adview.cn,REJECT\n"
        "DOMAIN-SUFFIX,adwhirl.com,REJECT\n"
        "DOMAIN-SUFFIX,adwo.com,REJECT\n"
        "DOMAIN-SUFFIX,adxmi.com,REJECT\n"
        "DOMAIN-SUFFIX,adzerk.net,REJECT\n"
        "DOMAIN-SUFFIX,allyes.com,REJECT\n"
        "DOMAIN-SUFFIX,anquan.org,REJECT\n"
        "DOMAIN-SUFFIX,aoodoo.feng.com,REJECT\n"
        "DOMAIN-SUFFIX,api.mobile.dianru.com,REJECT\n"
        "DOMAIN-SUFFIX,appads.com,REJECT\n"
        "DOMAIN-SUFFIX,appboy.com,REJECT\n"
        "DOMAIN-SUFFIX,applifier.com,REJECT\n"
        "DOMAIN-SUFFIX,applovin.com,REJECT\n"
        "DOMAIN-SUFFIX,appsflyer.com,REJECT\n"
        "DOMAIN-SUFFIX,atdmt.com,REJECT\n"
        "DOMAIN-SUFFIX,baifendian.com,REJECT\n"
        "DOMAIN-SUFFIX,bam.nr-data.net,REJECT\n"
        "DOMAIN-SUFFIX,beacon.sina.com.cn,REJECT\n"
        "DOMAIN-SUFFIX,beacon.tingyun.com,REJECT\n"
        "DOMAIN-SUFFIX,chance-ad.com,REJECT\n"
        "DOMAIN-SUFFIX,chartboost.com,REJECT\n"
        "DOMAIN-SUFFIX,clicktracks.com,REJECT\n"
        "DOMAIN-SUFFIX,clickzs.com,REJECT\n"
        "DOMAIN-SUFFIX,cm.ipinyou.com,REJECT\n"
        "DOMAIN-SUFFIX,cmcore.com,REJECT\n"
        "DOMAIN-SUFFIX,coremetrics.com,REJECT\n"
        "DOMAIN-SUFFIX,cps.360buy.com,REJECT\n"
        "DOMAIN-SUFFIX,dsp.youdao.com,REJECT\n"
        "DOMAIN-SUFFIX,emarbox.com,REJECT\n"
        "DOMAIN-SUFFIX,fastapi.net,REJECT\n"
        "DOMAIN-SUFFIX,fastclick.net,REJECT\n"
        "DOMAIN-SUFFIX,flurry.com,REJECT\n"
        "DOMAIN-SUFFIX,googlesyndication.com,REJECT\n"
        "DOMAIN-SUFFIX,googletagservices.com,REJECT\n"
        "DOMAIN-SUFFIX,guohead.com,REJECT\n"
        "DOMAIN-SUFFIX,guomob.com,REJECT\n"
        "DOMAIN-SUFFIX,hydra.alibaba.com,REJECT\n"
        "DOMAIN-SUFFIX,immob.cn,REJECT\n"
        "DOMAIN-SUFFIX,inmobi.com,REJECT\n"
        "DOMAIN-SUFFIX,istreamsche.com,REJECT\n"
        "DOMAIN-SUFFIX,jusha.com,REJECT\n"
        "DOMAIN-SUFFIX,kouyu.youdao.com,REJECT\n"
        "DOMAIN-SUFFIX,localytics.com,REJECT\n"
        "DOMAIN-SUFFIX,lotuseed.com,REJECT\n"
        "DOMAIN-SUFFIX,m.simaba.taobao.com,REJECT\n"
        "DOMAIN-SUFFIX,madmini.com,REJECT\n"
        "DOMAIN-SUFFIX,mediav.com,REJECT\n"
        "DOMAIN-SUFFIX,miaozhen.com,REJECT\n"
        "DOMAIN-SUFFIX,miidi.net,REJECT\n"
        "DOMAIN-SUFFIX,mixpanel.com,REJECT\n"
        "DOMAIN-SUFFIX,mng-ads.com,REJECT\n"
        "DOMAIN-SUFFIX,mobfox.com,REJECT\n"
        "DOMAIN-SUFFIX,mobisage.cn,REJECT\n"
        "DOMAIN-SUFFIX,mopub.com,REJECT\n"
        "DOMAIN-SUFFIX,mxpnl.com,REJECT\n"
        "DOMAIN-SUFFIX,networkbench.com,REJECT\n"
        "DOMAIN-SUFFIX,newrelic.com,REJECT\n"
        "DOMAIN-SUFFIX,ntalker.com,REJECT\n"
        "DOMAIN-SUFFIX,o2omobi.com,REJECT\n"
        "DOMAIN-SUFFIX,oadz.com,REJECT\n"
        "DOMAIN-SUFFIX,optimizely.com,REJECT\n"
        "DOMAIN-SUFFIX,overture.com,REJECT\n"
        "DOMAIN-SUFFIX,page.amap.com,REJECT\n"
        "DOMAIN-SUFFIX,pubnub.com,REJECT\n"
        "DOMAIN-SUFFIX,qtmojo.com,REJECT\n"
        "DOMAIN-SUFFIX,reachmax.cn,REJECT\n"
        "DOMAIN-SUFFIX,responsys.net,REJECT\n"
        "DOMAIN-SUFFIX,rollout.io,REJECT\n"
        "DOMAIN-SUFFIX,sandai.net,REJECT\n"
        "DOMAIN-SUFFIX,sax.sina.cn,REJECT\n"
        "DOMAIN-SUFFIX,sax.sina.com.cn,REJECT\n"
        "DOMAIN-SUFFIX,scorecardresearch.com,REJECT\n"
        "DOMAIN-SUFFIX,serving-sys.com,REJECT\n"
        "DOMAIN-SUFFIX,sitemeter.com,REJECT\n"
        "DOMAIN-SUFFIX,smartmad.com,REJECT\n"
        "DOMAIN-SUFFIX,sponsorpay.com,REJECT\n"
        "DOMAIN-SUFFIX,stat.m.jd.com,REJECT\n"
        "DOMAIN-SUFFIX,stat.t.sfht.com,REJECT\n"
        "DOMAIN-SUFFIX,statcounter.com,REJECT\n"
        "DOMAIN-SUFFIX,sysdig.com,REJECT\n"
        "DOMAIN-SUFFIX,tanx.com,REJECT\n"
        "DOMAIN-SUFFIX,tapjoyads.com,REJECT\n"
        "DOMAIN-SUFFIX,tdimg.com,REJECT\n"
        "DOMAIN-SUFFIX,tjlog.easou.com,REJECT\n"
        "DOMAIN-SUFFIX,tjlog.ps.easou.com,REJECT\n"
        "DOMAIN-SUFFIX,tjs.sjs.sinajs.cn,REJECT\n"
        "DOMAIN-SUFFIX,trafficmp.com,REJECT\n"
        "DOMAIN-SUFFIX,umtrack.com,REJECT\n"
        "DOMAIN-SUFFIX,union.youdao.com,REJECT\n"
        "DOMAIN-SUFFIX,unlitui.com,REJECT\n"
        "DOMAIN-SUFFIX,ushaqi.com,REJECT\n"
        "DOMAIN-SUFFIX,uyunad.com,REJECT\n"
        "DOMAIN-SUFFIX,vamaker.com,REJECT\n"
        "DOMAIN-SUFFIX,vpon.com,REJECT\n"
        "DOMAIN-SUFFIX,wanproxy.127.net,REJECT\n"
        "DOMAIN-SUFFIX,wiyun.com,REJECT\n"
        "DOMAIN-SUFFIX,wooboo.com.cn,REJECT\n"
        "DOMAIN-SUFFIX,wqmobile.com,REJECT\n"
        "DOMAIN-SUFFIX,wrating.com,REJECT\n"
        "DOMAIN-SUFFIX,ws.126.net,REJECT\n"
        "DOMAIN-SUFFIX,xiaozhen.com,REJECT\n"
        "DOMAIN-SUFFIX,xibao100.com,REJECT\n"
        "DOMAIN-SUFFIX,yiqifa.com,REJECT\n"
        "DOMAIN-SUFFIX,youmi.net,REJECT\n"
        "DOMAIN-SUFFIX,zhstatic.zhihu.com,REJECT\n"
        "DOMAIN-SUFFIX,ad.api.3g.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,ad.api.3g.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,ad.m.iqiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,adcontrol.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,adplay.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,afp.qiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,agn.aty.sohu.com,REJECT\n"
        "DOMAIN-SUFFIX,ark.letv.com,REJECT\n"
        "DOMAIN-SUFFIX,asimgs.pplive.cn,REJECT\n"
        "DOMAIN-SUFFIX,atm.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,cupid.iqiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,cupid.qiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,de.as.pptv.com,REJECT\n"
        "DOMAIN-SUFFIX,g.uusee.com,REJECT\n"
        "DOMAIN-SUFFIX,ifacelog.iqiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,iwstat.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,lives.l.qq.com,REJECT\n"
        "DOMAIN-SUFFIX,logstat.t.sfht.com,REJECT\n"
        "DOMAIN-SUFFIX,lstat.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,m.aty.sohu.com,REJECT\n"
        "DOMAIN-SUFFIX,n.mark.letv.com,REJECT\n"
        "DOMAIN-SUFFIX,nstat.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,pop.uusee.com,REJECT\n"
        "DOMAIN-SUFFIX,rcd.iqiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,stat.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,stat.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,static.g.ppstream.com,REJECT\n"
        "DOMAIN-SUFFIX,static.lstat.youku.com,REJECT\n"
        "DOMAIN-SUFFIX,static.qiyi.com,REJECT\n"
        "DOMAIN-SUFFIX,stats.tudou.com,REJECT\n"
        "DOMAIN-SUFFIX,traffic.uusee.com,REJECT\n"
        "IP-CIDR,123.125.117.0/22,REJECT,no-resolve\n"
        "FINAL,DIRECT\n"
        "\n"
        "[Host]\n";
        [[str dataUsingEncoding:NSUTF8StringEncoding ] writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"test.conf"] atomically:YES];
        downloadHostsFile();

        while (!isEnd) {
        }
    }
    return 0;
}


