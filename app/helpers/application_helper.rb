module ApplicationHelper
  def menu_link_to(link_text, link_path)
    link_to link_text, link_path, class: "nav-link"
  end

  def provider_sign_in_btn
    if devise_mapping.omniauthable?
      links = []
      resource_class.omniauth_providers.each do |provider|
        provider = link_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(resource_name, provider), class: "btn btn-primary d-block mb-3"
        links << provider
      end
    end
    render html: links.join.html_safe
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to("Dislike!", post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to("Like!", post_likes_path(post_id: post.id), method: :post)
    end
  end
end
