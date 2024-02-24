//
//  SUSettings.swift
//  CrossLand2
//
//  Created by Ki MNO on 2024/2/21.
//  Copyright © 2024 TRIStudio. All rights reserved.
//

import SwiftUI
import SnapKit

struct SUSettings: View {
    
    @State var disclosureGroup1_expanded = true
    
    @State var toggleAutoDownloadPicture = false
    

    
    var body: some View {
            VStack {
                List {
                    HStack {
                        Spacer()
                        Text("CrossLand 设置").font(.system(size: 24, weight: .bold)).padding(.top, 40).padding(.bottom, 40)
                        Spacer()
                    }.frame(alignment: .center).newHideListRowSeparator()
                    
                    
                    // User Settings
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            HStack {
                                Rectangle().frame(width: 20, height: 20).foregroundColor(Color.clear)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("X 岛用户登录").font(.system(size: 16, weight: .bold))
                                    Text("使用 X 岛账户登录以获取完整的 CrossLand 体验").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                NavigationLink(destination: {}, label: {}).frame(width: 10)
                            }.contentShape(Rectangle())
                                .onTapGesture {
                                    print("Go Login")
                            }
                            
                            HStack {
                                Rectangle().frame(width: 20, height: 20).foregroundColor(Color.clear)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("饼干管理").font(.system(size: 16, weight: .bold))
                                    Text("管理我的饼干").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                NavigationLink(destination: {}, label: {}).frame(width: 10)
                            }.contentShape(Rectangle())
                                .onTapGesture {
                                    print("Go Login")
                            }
                            
                        },
                        label: {
                            HStack {
                                Image(systemName: "person.circle").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("用户管理").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 5.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                    // Viewing Settings
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            HStack {
                                Rectangle().frame(width: 20, height: 20).foregroundColor(Color.clear)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("蜂窝数据下自动加载图片").font(.system(size: 16, weight: .bold))
                                }.padding(.leading, 10)
                                Spacer()
                                Toggle(isOn: $toggleAutoDownloadPicture, label: { }).frame(width: 60)
                            }
                            
                            HStack {
                                Rectangle().frame(width: 20, height: 20).foregroundColor(Color.clear)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("始终显示原图").font(.system(size: 16, weight: .bold))
                                }.padding(.leading, 10)
                                Spacer()
                                Toggle(isOn: $toggleAutoDownloadPicture, label: { }).frame(width: 60)
                            }
                            
                        },
                        label: {
                            HStack {
                                Image(systemName: "doc").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("浏览选项").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 4.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                    
                    
                    // Display Settings
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            HStack {
                                Image(systemName: "macwindow").scaledToFit()
                                    .frame(width: 20, height: 20)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("清晰视图 Beta").font(.system(size: 16, weight: .bold))
                                    Text("在 macOS 上以 100% 的缩放比例而并非默认的 77% 比例显示界面。此功能由 PixelPerfect 提供技术支持。\n你需要重新启动软件来应用此项更改。").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                Toggle(isOn: $toggleAutoDownloadPicture, label: { }).frame(width: 60)
                            }
                        },
                        label: {
                            HStack {
                                Image(systemName: "sun.max").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("显示设置").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 5.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                    
                    // Storage & Archive
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            
                            HStack {
                                Image(systemName: "archivebox").scaledToFit()
                                    .frame(width: 20, height: 20)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("内建数据搜寻 Beta").font(.system(size: 16, weight: .bold))
                                    Text("CrossLand 会自动缓存你浏览过的串并建立归档，下次你可以使用 Spotlight 功能搜寻到之前浏览过的串。\n注意：此功能无法搜索到从未浏览过的串。").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                Toggle(isOn: $toggleAutoDownloadPicture, label: { }).frame(width: 60)
                            }
                            
                            HStack {
                                Image(systemName: "trash").scaledToFit()
                                    .frame(width: 20, height: 20)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("清除所有数据").font(.system(size: 16, weight: .bold))
                                    Text("清除所有的缓存数据").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                NavigationLink(destination: {}, label: {}).frame(width: 10)
                            }
                        },
                        label: {
                            HStack {
                                Image(systemName: "externaldrive").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("存储与归档").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 5.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                    
                    // Notification
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            
                            HStack {
                                Image(systemName: "bell.badge").scaledToFit()
                                    .frame(width: 20, height: 20)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("通知提醒 Beta").font(.system(size: 16, weight: .bold))
                                    Text("CrossLand 会定期检查你的回复、订阅是否有更新，然后通过系统通知推送给你。\n此功能仅适用于 iPhone 与 iPad。").font(.system(size: 14, weight: .regular))
                                }.padding(.leading, 10)
                                Spacer()
                                Toggle(isOn: $toggleAutoDownloadPicture, label: { }).frame(width: 60)
                            }

                        },
                        label: {
                            HStack {
                                Image(systemName: "bell").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("通知与提醒").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 5.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                    
                    // Other
                    
                    Section(content: {
                        
                        DisclosureGroup(isExpanded: $disclosureGroup1_expanded, content: {
                            
                            HStack {
                                Rectangle().frame(width: 20, height: 20).foregroundColor(Color.clear)
                                VStack(alignment: .leading, spacing: 4.0) {
                                    Text("知识产权信息").font(.system(size: 16, weight: .bold))
                                }.padding(.leading, 10)
                                Spacer()
                                NavigationLink(destination: {}, label: {}).frame(width: 10)
                            }

                        },
                        label: {
                            HStack {
                                Image(systemName: "info.circle").scaledToFit()
                                    .frame(width: 20, height: 20).padding(.leading, 5.0).newAccentForegroundColor()
                                Text("其它").font(.system(size: 16, weight: .bold)).padding(.leading, 7.0)
                            }.frame(height: 25).padding(.leading, 5.0)
                        })
                    }, header: { }).newHideListRowSeparator()
                    
                }.listStyle(.inset)
                
            }
        

            
        }
    
}

extension View {
    func newTint(_ color: Color?) -> some View {
        if #available(iOS 15.0, *) {
            return self.tint(color)
        } else {
            return self.accentColor(color)
        }
    }
    
    func newHideListRowSeparator() -> some View {
        if #available(iOS 15.0, *) {
            return self.listRowSeparator(.hidden)
        } else {
            return self
        }
    }
    
    func newAccentForegroundColor() -> some View {
        if #available(iOS 15.0, *) {
            return self.foregroundStyle(Color.accentColor)
        } else {
            return self.foregroundColor(Color.accentColor)
        }
    }
    
}

#Preview {
    SUSettings()
}
