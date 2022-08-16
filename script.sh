repo=713636003426.dkr.ecr.ap-south-1.amazonaws.com/testrepo
tag=$(aws ecr describe-images --repository-name testrepo --output text --query 'sort_by(imageDetails,& imagePushedAt)[*].imageTags[*]' | tr '\t' '\n' | tail -1)
echo $tag
sed -i 's@apache:apache@'"$repo:$tag"'@' ./deploy.yaml
kubectl apply -f deploy.yaml